import 'dart:async';
import 'package:searchable_dropdown/src/properties/tooltip_props.dart';
import 'package:flutter/material.dart';

/// Tooltip for [SearchableDropdown] suggestion rows under a [CompositedTransformFollower].
///
/// Material [Tooltip] uses overlay layout that conflicts with another
/// follower-linked overlay. This uses a plain [OverlayEntry] positioned via
/// [RenderBox.localToGlobal] instead.

class MenuItemTooltip extends StatefulWidget {
  final Widget child;
  final String message;
  final TooltipProps tooltipProps;

  const MenuItemTooltip({
    super.key,
    required this.child,
    required this.message,
    this.tooltipProps = const TooltipProps(),
  });

  @override
  State<MenuItemTooltip> createState() =>
      _SearchableDropdownMenuItemTooltipState();
}

class _SearchableDropdownMenuItemTooltipState extends State<MenuItemTooltip> {
  OverlayEntry? _overlayEntry;
  Timer? _showTimer;

  @override
  void dispose() {
    _showTimer?.cancel();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _scheduleShow() {
    _showTimer?.cancel();
    final wait = widget.tooltipProps.waitDuration ?? Duration.zero;
    if (wait.inMicroseconds > 0) {
      _showTimer = Timer(wait, () {
        if (mounted) _insertOverlay();
      });
    } else {
      _insertOverlay();
    }
  }

  BoxDecoration _defaultDecoration(ThemeData theme) {
    return BoxDecoration(
      color: theme.brightness == Brightness.dark
          ? Colors.white.withValues(alpha: 0.9)
          : Colors.grey.shade700.withValues(alpha: 0.9),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    );
  }

  void _insertOverlay() {
    if (!mounted || widget.message.isEmpty) return;
    if (_overlayEntry != null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize || !box.attached) return;

    final overlayState = Overlay.maybeOf(context);
    if (overlayState == null) return;

    final anchor = box.localToGlobal(Offset.zero) & box.size;
    final theme = Theme.of(context);
    final tt = TooltipTheme.of(context);
    final props = widget.tooltipProps;
    final textDir = Directionality.of(context);

    final textStyle = props.textStyle ??
        tt.textStyle ??
        theme.textTheme.bodyMedium!.copyWith(
          color: theme.brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          fontSize: theme.platform == TargetPlatform.iOS ||
              theme.platform == TargetPlatform.android
              ? 14.0
              : 12.0,
        );

    final padding = props.padding ??
        EdgeInsets.symmetric(
          horizontal: theme.platform == TargetPlatform.windows ||
              theme.platform == TargetPlatform.linux ||
              theme.platform == TargetPlatform.macOS
              ? 8.0
              : 16.0,
          vertical: 4.0,
        );

    const maxBubbleWidth = 280.0;
    final painter = TextPainter(
      text: TextSpan(text: widget.message, style: textStyle),
      textDirection: textDir,
      maxLines: 12,
      ellipsis: '...',
    )..layout(maxWidth: maxBubbleWidth - padding.horizontal);

    final bubbleW = painter.width + padding.horizontal;
    final bubbleH = painter.height + padding.vertical;

    final media = MediaQuery.of(context);
    final screenW = media.size.width;
    final screenH = media.size.height;
    final safeTop = media.padding.top + 4;
    final safeBottom = screenH - media.padding.bottom - 4;

    final verticalOffset = props.verticalOffset ?? 24.0;
    final preferBelow = props.preferBelow ?? true;

    double top;
    if (preferBelow) {
      top = anchor.bottom + verticalOffset * 0.35;
    } else {
      top = anchor.top - bubbleH - verticalOffset * 0.35;
    }

    var left = anchor.left.clamp(8.0, screenW - bubbleW - 8.0);
    top = top.clamp(safeTop, safeBottom - bubbleH);

    final margin = props.margin?.resolve(textDir) ?? EdgeInsets.zero;
    left += margin.left;
    top += margin.top;

    final BoxDecoration bubbleDecoration;
    if (props.decoration is BoxDecoration) {
      bubbleDecoration = props.decoration as BoxDecoration;
    } else if (props.decoration != null) {
      bubbleDecoration = BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.9)
            : Colors.grey.shade700.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      );
    } else {
      bubbleDecoration = _defaultDecoration(theme);
    }

    _overlayEntry = OverlayEntry(
      builder: (ctx) => Positioned(
        left: left,
        top: top,
        child: IgnorePointer(
          child: Material(
            elevation: 2,
            color: Colors.transparent,
            child: DecoratedBox(
              decoration: bubbleDecoration,
              child: Padding(
                padding: padding,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxBubbleWidth),
                  child: Text(
                    widget.message,
                    style: textStyle,
                    textAlign: props.textAlign ?? TextAlign.start,
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.message.isEmpty) {
      return widget.child;
    }

    return MouseRegion(
      onEnter: (_) => _scheduleShow(),
      onExit: (_) {
        _showTimer?.cancel();
        _removeOverlay();
      },
      child: widget.child,
    );
  }
}