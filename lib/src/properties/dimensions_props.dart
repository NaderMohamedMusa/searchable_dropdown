import 'package:flutter/material.dart';

class DimensionsProps {
  /// height of the searchable dropdown field
  final double? height;

  /// width of the searchable dropdown field
  final double? width;

  /// Offset of the searchable dropdown field
  final Offset? offset;

  /// Space Above the searchable dropdown field
  final double? top;

  /// Space Below the searchable dropdown field
  final double? bottom;

  DimensionsProps({
    this.height,
    this.width,
    this.offset,
    this.top,
    this.bottom,
  });

  DimensionsProps copyWith({
    double? height,
    double? width,
    Offset? offset,
    double? top,
    double? bottom,
  }) {
    return DimensionsProps(
      height: height ?? this.height,
      width: width ?? this.width,
      offset: offset ?? this.offset,
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
    );
  }
}