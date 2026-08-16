import 'package:flutter/material.dart';
import 'menu_committed_selection_theme.dart';
import 'tooltip_props.dart';

/// Styling, custom row builder, and tooltips for suggestions.
/// Per-row data (`searchKey`, `item`, `child`, ...) still comes from the item object.
/// This object holds the **defaults** applied when building those rows.
class SearchableListItemProps<T> {
  /// Text style when the row has no [ListItemProps.child].
  final TextStyle? itemTextStyle;

  /// Per-row decoration in the suggestion list.
  final BoxDecoration? itemDecoration;

  /// Custom row when [SearchableDropdown.asyncItems] is used
  /// without [ListItemProps.child].
  final Widget Function(BuildContext context, T item, bool isSelected)?
  itemBuilder;

  /// When true, each suggestion row shows a [Tooltip].
  final bool enableMenuItemTooltip;

  /// Tooltip text per suggestion; when null, [SearchableDropdown...]
  final String Function(T item)? itemTooltip;

  /// Styling for suggestion tooltips.
  final TooltipProps menuItemTooltipProps;

  /// Theme for rows whose item matches the field's committed
  /// row appears in the list). Keyboard ↑/↓ focus uses [Suggestion...]
  /// both can apply on the same row (colors are blended).
  final MenuCommittedSelectionTheme? committedSelectionTheme;

  const SearchableListItemProps({
    this.itemTextStyle,
    this.itemDecoration,
    this.itemBuilder,
    this.enableMenuItemTooltip = false,
    this.itemTooltip,
    this.menuItemTooltipProps = const TooltipProps(),
    this.committedSelectionTheme,
  });
}

