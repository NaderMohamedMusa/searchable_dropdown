import 'dart:developer';
import 'package:searchable_dropdown/src/properties/list_view_props.dart';
import 'package:searchable_dropdown/src/properties/list_item_props.dart';
import 'package:searchable_dropdown/src/properties/menu_committed_selection_theme.dart';
import 'package:searchable_dropdown/src/properties/tooltip_props.dart';
import 'package:searchable_dropdown/src/widgets/menu_item_tooltip.dart';
import 'package:searchable_dropdown/src/utils/decoration.dart';
import 'package:searchable_dropdown/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Suggestion list for [SearchableDropdown] overlay (fixed or dynamic height)
class MenuListView<T> extends StatefulWidget {
  final ScrollController? scrollController;
  final MenuDirection menuDirection;
  final int? selected;
  final double? maxHeight;
  final bool dynamicHeight;
  final void Function(PointerDownEvent) onTapOutside;
  final List<ListItemProps<T>> list;
  final SuggestionDecoration? menuDecoration;
  final void Function(ListItemProps<T> item, int index) onItemTap;
  final BoxDecoration? itemDecoration;
  final Color? marginColor;
  final double itemHeight;
  final int maxVisibleItemsInViewport;
  final TextStyle? itemTextStyle;
  final void Function(double, double)? onScroll;
  final ListViewProps listViewProps;
  final Widget Function(
      BuildContext context,
      ListItemProps<T> item,
      int index,
      bool isKeyboardHighlighted,
      bool isCommittedSelection,
      )? itemBuilder;
  final Widget? loadingMoreFooter;
  final double? loadingMoreFooterHeight;
  final bool enableMenuItemTooltip;
  final TooltipProps menuItemTooltipProps;
  final String Function(ListItemProps<T> item) menuItemTooltip;

  /// Row indices whose data matches the field's committed selection
  final Set<int> committedSelectionIndices;

  /// Background / text styling for [committedSelectionIndices] rows.
  final MenuCommittedSelectionTheme? committedSelectionTheme;

  MenuListView({
    super.key,
    this.maxHeight,
    required this.scrollController,
    required this.selected,
    required this.list,
    required this.itemHeight,
    required this.onTapOutside,
    required this.menuDecoration,
    required this.itemDecoration,
    required this.maxVisibleItemsInViewport,
    required this.onItemTap,
    this.onScroll,
    this.itemTextStyle,
    this.marginColor,
    this.menuDirection = MenuDirection.down,
    required this.dynamicHeight,
    this.listViewProps = const ListViewProps(),
    this.itemBuilder,
    this.loadingMoreFooter,
    this.loadingMoreFooterHeight,
    this.enableMenuItemTooltip = false,
    this.menuItemTooltipProps = const TooltipProps(),
    required this.menuItemTooltip,
    this.committedSelectionIndices = const <int>{},
    this.committedSelectionTheme,
  });

  @override
  State<MenuListView<T>> createState() => _SFListViewState<T>();
}

class _SFListViewState<T> extends State<MenuListView<T>> {
  late final ScrollController _scrollController;
  VoidCallback? _scrollListener;
  int? _lastEnsuredVisibleSelectedIndex;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    listenToScrollEvents();
    if (widget.selected != null) {
      WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
        if (!_scrollController.hasClients) return;
        if (widget.selected! > (widget.maxVisibleItemsInViewport / 2)) {
          if ((widget.list.length - widget.selected!) <
              widget.maxVisibleItemsInViewport) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          } else {
            _scrollController.jumpTo(
              (widget.selected! - widget.maxVisibleItemsInViewport / 2) *
                  widget.itemHeight,
            );
          }
        }
      });
    }
  }

  void listenToScrollEvents() {
    if (_scrollListener != null) {
      _scrollController.removeListener(_scrollListener!);
      _scrollListener = null;
    }
    final onScroll = widget.onScroll;
    if (onScroll == null) return;
    _scrollListener = () {
      if (!_scrollController.hasClients) return;
      onScroll(
        _scrollController.position.pixels,
        _scrollController.position.maxScrollExtent,
      );
    };
    _scrollController.addListener(_scrollListener!);
  }

  @override
  void dispose() {
    if (_scrollListener != null) {
      _scrollController.removeListener(_scrollListener!);
      _scrollListener = null;
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MenuListView<T> oldWidget) {
    if (oldWidget.onScroll != widget.onScroll) {
      listenToScrollEvents();
    }
    super.didUpdateWidget(oldWidget);
  }

  Widget _wrapMenuItemTooltip(Widget child, String message) {
    if (!widget.enableMenuItemTooltip) return child;
    return MenuItemTooltip(
      message: message,
      tooltipProps: widget.menuItemTooltipProps,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasLoadMoreFooter = widget.loadingMoreFooter != null;

    BoxDecoration getDecoration(int index) {
      final isKeyboardSelected =
          widget.selected != null && widget.selected == index;
      final isCommitted =
      widget.committedSelectionIndices.contains(index);
      final keyboardColor = widget.menuDecoration?.selectionColor ??
          Theme.of(context).highlightColor;
      final committedTheme = widget.committedSelectionTheme;
      final cs = Theme.of(context).colorScheme;

      final base = widget.itemDecoration ?? const BoxDecoration();

      final isLastDataRow = index == widget.list.length - 1;
      final border = base.border ??
          (isLastDataRow && !hasLoadMoreFooter
              ? null
              : Border(
            bottom: BorderSide(
              color: widget.marginColor ??
                  cs.onSurface.withAlpha(25),
            ),
          ));

      if (isCommitted && committedTheme?.decoration != null) {
        final d = committedTheme!.decoration!;
        return d.copyWith(border: border ?? d.border);
      }

      Color? fill;
      if (isCommitted) {
        fill = committedTheme?.backgroundColor ??
            cs.primaryContainer.withValues(alpha: 0.42);
      }

      if (isKeyboardSelected) {
        if (fill != null) {
          fill = Color.alphaBlend(
            keyboardColor.withValues(alpha: 0.45),
            fill,
          );
        } else {
          fill = keyboardColor;
        }
      }

      return base.copyWith(
        color: fill,
        border: border,
      );
    }

    TextStyle? rowItemTextStyle(int index) {
      final base = widget.itemTextStyle;
      final committed = widget.committedSelectionIndices.contains(index);
      final t = widget.committedSelectionTheme?.textStyle;
      if (committed && t != null) {
        return base == null ? t : base.merge(t);
      }
      return base;
    }

    final base = kDefaultSuggestionDecoration(context);
    final decoration = base.merge(widget.menuDecoration);

    return ClipRRect(
      borderRadius: decoration.borderRadius ?? kDefaultShapeBorder.borderRadius,
      child: Container(
        decoration: decoration,
        child: LimitedBox(
          maxHeight: widget.maxHeight ?? double.infinity,
          child: ListView.builder(
            shrinkWrap: widget.listViewProps.shrinkWrap || widget.maxHeight == null,
            reverse: widget.menuDirection == MenuDirection.up,
            padding: widget.listViewProps.padding ?? EdgeInsets.zero,
            controller: _scrollController,
            itemCount: widget.list.length + (widget.loadingMoreFooter != null ? 1 : 0),
            physics: widget.list.length + (widget.loadingMoreFooter != null ? 1 : 0) == 0
                ? const NeverScrollableScrollPhysics()
                : (widget.listViewProps.physics ?? const ScrollPhysics()),
            clipBehavior: widget.listViewProps.clipBehavior,
            addAutomaticKeepAlives: widget.listViewProps.addAutomaticKeepAlives,
            addRepaintBoundaries: widget.listViewProps.addRepaintBoundaries,
            addSemanticIndexes: widget.listViewProps.addSemanticIndexes,
            cacheExtent: widget.listViewProps.cacheExtent,
            itemExtent: widget.listViewProps.itemExtent,
            itemBuilder: (BuildContext context, int index) {
              if (hasLoadMoreFooter && index == widget.list.length) {
                final fh = widget.loadingMoreFooterHeight ?? widget.itemHeight;
                return Material(
                  color: decoration.color,
                  child: SizedBox(
                    height: widget.dynamicHeight ? null : fh,
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: decoration.itemPadding,
                        child: widget.loadingMoreFooter,
                      ),
                    ),
                  ),
                );
              }

              return KeepAliveListItem(
                child: Builder(
                  builder: (BuildContext context) {
                    if (widget.selected != null &&
                        widget.selected == index &&
                        _lastEnsuredVisibleSelectedIndex != widget.selected) {
                      _lastEnsuredVisibleSelectedIndex = widget.selected;
                      SchedulerBinding.instance.addPostFrameCallback((Duration t) {
                        if (!mounted) return;
                        if (widget.selected != index) return;
                        try {
                          Scrollable.ensureVisible(
                            context,
                            alignment: 0.1,
                            duration: const Duration(milliseconds: 300),
                          );
                        } catch (e) {
                          log('Error scrolling to selected item: $e');
                        }
                      });
                    }

                    final bool keyboardHighlight =
                        widget.selected != null && widget.selected == index;
                    final bool committedHighlight =
                    widget.committedSelectionIndices.contains(index);

                    Widget row = Material(
                      color: decoration.color,
                      child: InkWell(
                        hoverColor:
                        decoration.hoverColor ?? Theme.of(context).hoverColor,
                        onTap: () => widget.onItemTap(widget.list[index], index),
                        child: Container(
                          height: widget.dynamicHeight ? null : widget.itemHeight,
                          key: widget.list[index].key,
                          width: double.infinity,
                          decoration: getDecoration(index),
                          // A transparent [Material] sits directly above the row
                          // content so that an item builder returning a [ListTile]
                          // (or other Material widget) has a [Material] ancestor
                          // that is not separated from it by the colored
                          // [DecoratedBox] produced by [getDecoration]. Without
                          // this, Flutter asserts that the ListTile background and
                          child: Material(
                            type: MaterialType.transparency,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: decoration.itemPadding,
                                child: widget.itemBuilder != null
                                    ? widget.itemBuilder!(
                                  context,
                                  widget.list[index],
                                  index,
                                  keyboardHighlight,
                                  committedHighlight,
                                )
                                    : widget.list[index].child ??
                                    Text(
                                      widget.list[index].searchKey,
                                      style: rowItemTextStyle(index),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );

                    row = _wrapMenuItemTooltip(
                      row,
                      widget.menuItemTooltip(widget.list[index]),
                    );

                    return TextFieldTapRegion(
                      onTapOutside: (PointerDownEvent x) {
                        widget.onTapOutside(x);
                      },
                      child: row,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

SuggestionDecoration kDefaultSuggestionDecoration(BuildContext context) {
  final onSurface = Theme.of(context).colorScheme.onSurface;
  return SuggestionDecoration(
    color: Theme.of(context).colorScheme.surface,
    border: Border.all(color: onSurface.withAlpha(25)),
    boxShadow: [
      BoxShadow(
        color: onSurface.withAlpha(25),
        blurRadius: 8,
        spreadRadius: 2,
        offset: const Offset(2, 5),
      ),
    ],
  );
}

class KeepAliveListItem extends StatefulWidget {
  const KeepAliveListItem({super.key, required this.child});

  final Widget child;

  @override
  State<KeepAliveListItem> createState() => _KeepAliveListItemState();
}

class _KeepAliveListItemState extends State<KeepAliveListItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}