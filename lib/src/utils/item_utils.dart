import 'package:flutter/material.dart';
import '../properties/list_item_props.dart';
import 'typedef_data_type.dart';

class ItemUtils {
  ItemUtils._();

  static String itemAsString<T>(
      T? data,
      SearchableDropdownItemAsString<T>? itemAsStringFn,
      ) {
    if (data == null) return "";
    if (itemAsStringFn != null) return itemAsStringFn(data);
    return data.toString();
  }

  static String tooltipText<T>(
      T? data,
      SearchableDropdownItemAsString<T>? tooltipFn,
      SearchableDropdownItemAsString<T>? itemAsStringFn,
      ) {
    if (data == null) return "";
    if (tooltipFn != null) return tooltipFn(data);
    return itemAsString(data, itemAsStringFn);
  }

  static bool contextIsActiveForLookup(BuildContext context) =>
      context is Element && context.mounted;

  static bool selectedValueMatchesItems<T>(
      List<T> items,
      ListItemProps<T>? selectedValue,
      SearchableDropdownItemAsString<T>? itemAsString,
      SearchableDropdownCompareFn<T>? compareFn,
      ) {
    if (selectedValue == null) return true;
    if (itemAsString == null) return false;

    for (final t in items) {
      if (selectedValue.item != null) {
        if (compareFn != null) {
          if (compareFn(selectedValue.item as T, t)) return true;
        } else if (selectedValue.item == t) {
          return true;
        }
      }
      if (itemAsString(t) == selectedValue.searchKey) return true;
    }
    return false;
  }
}