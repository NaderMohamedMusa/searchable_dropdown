enum MenuAlign {
  bottomStart,
  bottomCenter,
  bottomEnd,
  topStart,
  topCenter,
  topEnd,
}

/// When the search overlay list is shown relative to focus / typing.
enum MenuVisibility {
  /// Show the list when the search field receives focus.
  expand,

  /// Keep the overlay hidden until the user types at least one character.
  hidden,
}

/// Focus behavior after the user selects a row in the search overlay.
enum MenuSelectAction {
  /// Move focus to the next field in tab order.
  next,

  /// Close the keyboard and unfocus (default).
  unfocus,

  /// Keep focus on this field after a selection so Tab order continues from here
  /// (forms / keyboard navigation). The menu stays closed until the user opens it again.
  keepFocus,
}

/// When [SearchableDropdown.multiSelection] notifies [onChangedMultiSelection].
enum MultiSelectionCommitPolicy {
  /// Parent [onChangedMultiSelection] runs on every row tap / chip remove.
  immediate,

  /// Parent is notified once when the suggestion menu closes (tap outside,
  /// unfocus, Tab away) with the final working selection.
  onMenuClose,

  /// Parent is notified only from the footer **OK** action (requires
  /// [SearchableDropdown.multiFooter]). Dismiss / **Cancel** restores the
  /// selection from when the menu opened without calling the callback.
  onFooterOk,
}

/// Where the search overlay panel is placed relative to the field.
enum MenuDirection {
  /// Panel below the search field.
  down,

  /// Panel above the search field.
  up,

  /// Choose up or down based on available space.
  flex,
}