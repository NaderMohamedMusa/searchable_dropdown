import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;

import '../utils/enums.dart';
import '../utils/typedef_data_type.dart' show PositionCallback;
import 'infinite_scroll_props.dart';
import 'list_item_props.dart';
import 'list_view_props.dart';
import 'scrollbar_props.dart';
import '../utils/decoration.dart';

/// Menu and list configuration for the [SearchableDropdown] suggestion overlay.
///
/// [MenuProps], [ScrollbarProps], [ListViewProps], [SearchableListItemProps]
/// configure different parts of the suggestion menu.
///
/// **Scrolling / row size:** [ListViewProps.itemHeight],
/// [ListViewProps.controller], and related properties configure the list.
///
/// **Loading / empty:** [loadingBuilder] and [loadingMoreBuilder] work with
/// [emptyBuilder], [showEmpty], [menuLoadingHeight], and [animationDuration].
///
/// **Cache / filter:** [cacheItems] and [disableFilter] tune how items
/// are merged and filtered.
///
/// **Overlay list:** [ListViewProps.dynamicHeight],
/// [maxMenuBoxHeight], [ListViewProps.maxVisibleItemsInViewport],
/// [menuDecoration], [menuDirection], [menuVisibility], [menuSelectAction],
/// [offset], and [maxLength] / [maxLengthEnforcement] configure the list.
///
/// **Menu item tooltips:** [SearchableListItemProps.enableMenuItemTooltip]
/// and [SearchableListItemProps.menuItemTooltipProps] configure per-row
/// tooltips.
class MenuProps<T> {
  /// Scrollbar for the list ([ScrollbarProps]); optional
  /// [ScrollbarProps.scrollbarDecoration].
  final ScrollbarProps scrollbarProps;

  /// List layout, scroll [ScrollController], row height, viewport cap,
  /// and list behavior.
  final ListViewProps listViewProps;

  /// Default row appearance, [itemBuilder], and menu tooltips.
  final SearchableListItemProps<T> listItemProps;

  /// Builder for the initial loading state.
  final Widget Function(BuildContext context, String searchText)?
  loadingBuilder;

  /// Builder for the loading-more state.
  final Widget Function(BuildContext context, String searchText)?
  loadingMoreBuilder;

  /// Shown when there are no rows.
  ///
  /// If null, the overlay uses [SizedBox.shrink] for the empty slot.
  final Widget Function(BuildContext context, String searchText)?
  emptyBuilder;

  /// Height of the loading panel while [SearchableDropdown.asyncItems]
  /// resolves.
  ///
  /// If null, uses `70` (default height for the first-load spinner
  /// in the overlay).
  final double? menuLoadingHeight;

  /// Duration for overlay animations.
  final Duration animationDuration;

  final MenuAlign? align;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? barrierColor;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final bool borderOnForeground;
  final String? barrierLabel;
  final PositionCallback? positionCallback;
  final AnimationStyle? popUpAnimationStyle;
  final String? color;
  final String? semanticLabel;
  final Color? surfaceTintColor;
  final EdgeInsets? margin;

  /// When true, the overlay uses the empty state even when the stream
  /// is empty.
  final bool showEmpty;

  /// Optional max size for the suggestion overlay.
  final BoxConstraints? menuConstraints;

  /// Optional paging for infinite scroll.
  final InfiniteScrollProps? infiniteScrollProps;

  final bool disableFilter;

  final bool cacheItems;

  /// Max height of the list box when [ListViewProps.dynamicHeight] is true.
  final double? maxMenuBoxHeight;

  /// Passed to the inner [TextFormField] ([TextField.maxLength]).
  final int? maxLength;

  /// Passed to the inner [TextFormField]
  /// ([TextField.maxLengthEnforcement]).
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Decoration of the list panel.
  final SuggestionDecoration? menuDecoration;

  /// Whether the panel opens below, above, or based on available space.
  final MenuDirection menuDirection;

  /// Show list on focus or only after typing.
  final MenuVisibility menuVisibility;

  /// Focus behavior after selecting a row.
  final MenuSelectAction? menuSelectAction;

  /// Extra offset for positioning the overlay relative to the search field.
  final Offset? offset;

  const MenuProps({
    this.scrollbarProps = const ScrollbarProps(),
    this.listViewProps = const ListViewProps(),
    this.listItemProps = const SearchableListItemProps(),
    this.loadingBuilder,
    this.loadingMoreBuilder,
    this.emptyBuilder,
    this.menuLoadingHeight,
    this.animationDuration = const Duration(milliseconds: 300),
    this.align,
    this.shape,
    this.elevation,
    this.barrierColor,
    this.backgroundColor,
    this.barrierDismissible = true,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.shadowColor,
    this.borderOnForeground = false,
    this.barrierLabel,
    this.positionCallback,
    this.popUpAnimationStyle,
    this.color,
    this.semanticLabel,
    this.surfaceTintColor,
    this.margin,
    this.showEmpty = false,
    this.menuConstraints,
    this.infiniteScrollProps,
    this.disableFilter = false,
    this.cacheItems = false,
    this.maxMenuBoxHeight,
    this.maxLength,
    this.maxLengthEnforcement,
    this.menuDecoration,
    this.menuDirection = MenuDirection.down,
    this.menuVisibility = MenuVisibility.expand,
    this.menuSelectAction = MenuSelectAction.unfocus,
    this.offset,
  }) : assert(
  !(cacheItems && disableFilter),
  'cacheItems and disableFilter cannot both be true',
  );
}