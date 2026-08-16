import 'dart:async';
import 'package:flutter/material.dart';
import '../properties/load_props.dart';
import '../properties/list_item_props.dart';

typedef SearchableDropdownOnFind<T> = FutureOr<List<T>> Function(
    String filter,
    LoadProps? loadProps,
    );

/// Suggestion row when [SearchableDropdown.asyncItems] supplies plain `T` values
typedef SearchableDropdownSuggestionItemBuilder<T> = Widget Function(
    BuildContext context,
    T item,
    bool isHighlighted,
    );

/// Async/sync suggestion source returning [ListItemProps] rows.
/// Use [LoadProps.skip] `0` for a new search (query change) and `skip` equal to
/// loaded rows to append the next page when the list is scrolled to the end.
typedef SearchableDropdownOnFindListItems<T> = FutureOr<List<ListItemProps<T>>>
Function(
    String filter,
    LoadProps? loadProps,
    );

typedef SearchableDropdownItemAsString<T> = String Function(T item);
typedef SearchableDropdownFilterFn<T> = bool Function(T item, String filter);
typedef SearchableDropdownCompareFn<T> = bool Function(T item1, T item2);

/// Closed-field UI for the committed selection ([TextProps.selectedItemBuilder])
typedef SearchableDropdownBuilder<T> = Widget Function(
    BuildContext context,
    T? selectedItem,
    );

typedef PositionCallback = RelativeRect Function(
    RenderBox dropdownBox,
    RenderBox overlay,
    );

typedef InfiniteScrollBuilder = Widget Function(
    BuildContext context,
    int loadedItems,
    );