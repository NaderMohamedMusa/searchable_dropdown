import 'package:flutter/material.dart';

/// Visual styling for suggestion rows that match the field's
/// **committed** selection
/// ([SearchableDropdown.selectedValue] /
/// [SearchableDropdown.selectedItem] / multi-select),
/// independent of keyboard ↑/↓ highlight.
///
/// Pass via [SearchableListItemProps.committedSelectionTheme].
class MenuCommittedSelectionTheme {
  /// Row background when this theme has no [decoration].
  ///
  /// When null and [decoration] is null, a light
  /// [ColorScheme.primaryContainer] tint is used so the
  /// committed row stays visible.
  final Color? backgroundColor;

  /// Merged over the default row /
  /// [SearchableListItemProps.itemTextStyle] for default [Text] rows.
  final TextStyle? textStyle;

  /// Full row [BoxDecoration] override
  /// (background, border radius, gradient, ...).
  ///
  /// When non-null, takes precedence over [backgroundColor]
  /// for the row container.
  ///
  /// Menu row separators still merge into [BoxDecoration.border]
  /// when appropriate.
  final BoxDecoration? decoration;

  const MenuCommittedSelectionTheme({
    this.backgroundColor,
    this.textStyle,
    this.decoration,
  });

  MenuCommittedSelectionTheme copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    BoxDecoration? decoration,
  }) {
    return MenuCommittedSelectionTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      decoration: decoration ?? this.decoration,
    );
  }
}