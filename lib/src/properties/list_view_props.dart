import 'package:flutter/material.dart';

class ListViewProps {
  final HitTestBehavior hitTestBehavior;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final Widget? prototypeItem;
  final ItemExtentBuilder? itemExtentBuilder;
  final ChildIndexGetter? findChildIndexCallback;

  /// Fixed height of each item.
  final double itemHeight;

  /// Whether item height should be calculated dynamically.
  final bool dynamicHeight;

  /// Maximum number of visible items in the viewport.
  final int maxVisibleItemsInViewport;

  /// Margin/background color around the list.
  final Color? marginColor;

  /// Height of the infinite-scroll footer row.
  final double? loadingMoreFooterHeight;

  const ListViewProps({
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = true,
    this.padding = const EdgeInsets.symmetric(vertical: 0),
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.prototypeItem,
    this.itemExtentBuilder,
    this.findChildIndexCallback,
    this.itemHeight = 51.0,
    this.dynamicHeight = false,
    this.maxVisibleItemsInViewport = 5,
    this.marginColor,
    this.loadingMoreFooterHeight,
  });
}

class ListItemProps<T> {
  Key? key;
  final String searchKey;
  final T? item;
  final String? value;
  final Widget? child;

  ListItemProps(
      this.searchKey, {
        this.child,
        this.item,
        this.value,
        this.key,
      });

  ListItemProps<T> copyWith({
    String? searchKey,
    T? item,
    String? value,
    Widget? child,
    Key? key,
  }) {
    return ListItemProps<T>(
      searchKey ?? this.searchKey,
      item: item ?? this.item,
      value: value ?? this.value,
      child: child ?? this.child,
      key: key ?? this.key,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ListItemProps &&
            runtimeType == other.runtimeType &&
            searchKey == other.searchKey;
  }

  @override
  int get hashCode => searchKey.hashCode;
}

/// extension to check if an Object is present in List<Object>
extension ListContainsObject<T> on List<T> {
  bool containsObject(T object) {
    for (var item in this) {
      if (object == item) {
        return true;
      }
    }
    return false;
  }
}