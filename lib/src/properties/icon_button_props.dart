import 'package:flutter/material.dart';

abstract class IconButtonProps {
  final Widget icon;
  final double? iconSize;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final double? splashRadius;
  final Color? color;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;
  final Color? disabledColor;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? tooltip;
  final bool? enableFeedback;
  final BoxConstraints? constraints;
  final ButtonStyle? style;
  final bool isVisible;
  final bool? isSelected;
  final Widget? selectedIcon;

  const IconButtonProps({
    required this.icon,
    this.isVisible = false,
    this.iconSize = 16.0,
    this.visualDensity = VisualDensity.compact,
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = Alignment.center,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.mouseCursor = SystemMouseCursors.click,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback = false,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
  }) : assert(splashRadius == null || splashRadius > 0);
}