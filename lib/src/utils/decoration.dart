import 'package:flutter/material.dart';

/// Defines the visual properties and behavior of a scrollbar.
class ScrollbarDecoration {
  /// The [OutlinedBorder] of the scrollbar's thumb.
  ///
  /// Only one of [radius] and [shape] may be specified. For a rounded rectangle,
  /// it's simplest to just specify [radius]. By default, the scrollbar thumb's
  /// shape is a simple rectangle.
  final OutlinedBorder? shape;

  /// The [Radius] of the scrollbar's thumb.
  ///
  /// Only one of [radius] and [shape] may be specified. For a rounded rectangle,
  /// it's simplest to just specify [radius].
  final Radius? radius;

  /// The thickness of the scrollbar's thumb.
  final double? thickness;

  /// Mustn't be null and the value has to be greater or equal to `minOverscrollLength`,
  /// which in turn is >= 0. Defaults to 18.0.
  final double minThumbLength;

  /// The [Color] of the scrollbar's thumb.
  final Color? thumbColor;

  /// Defines whether to show the scrollbar track.
  final bool? trackVisibility;

  /// The [Radius] of the scrollbar's track.
  final Radius? trackRadius;

  /// The [Color] of the scrollbar's track.
  final Color? trackColor;

  /// The [Color] of the scrollbar's track border.
  final Color? trackBorderColor;

  /// The [Duration] of the fade animation.
  final Duration fadeDuration;

  /// Defines whether to show the scrollbar always or only when scrolling.
  /// Defaults to `true`.
  final bool? thumbVisibility;

  /// The [Duration] of time until the fade animation begins.
  /// Cannot be null, defaults to a [Duration] of 600 milliseconds.
  final Duration timeToFade;

  /// The [Duration] of time that a LongPress will trigger the drag gesture of the scrollbar thumb.
  /// Cannot be null, defaults to 100 milliseconds.
  final Duration pressDuration;

  /// Dictates the orientation of the scrollbar.
  final ScrollbarOrientation orientation;

  /// Whether the Scrollbar should be interactive and respond to dragging on the thumb.
  /// Defaults to true when null.
  final bool? interactive;

  /// Distance from the scrollbar thumb's side to the nearest cross axis edge in logical pixels.
  /// Defaults to zero.
  final double? crossAxisMargin;

  const ScrollbarDecoration({
    this.minThumbLength = 18.0,
    this.thumbVisibility = true,
    this.radius,
    this.thickness,
    this.thumbColor,
    this.shape,
    this.orientation = ScrollbarOrientation.right,
    this.trackVisibility,
    this.trackRadius,
    this.crossAxisMargin = 0,
    this.trackColor,
    this.interactive = true,
    this.trackBorderColor,
    this.fadeDuration = const Duration(milliseconds: 300),
    this.timeToFade = const Duration(milliseconds: 600),
    this.pressDuration = const Duration(milliseconds: 100),
  });
}

class SuggestionDecoration extends BoxDecoration {
  /// Padding around the suggestion item.
  final EdgeInsetsGeometry itemPadding;

  /// Padding around the suggestion list.
  @override
  final EdgeInsetsGeometry padding;

  /// Color when the suggestion is hovered.
  /// Defaults to `Theme.of(context).hoverColor`.
  final Color? hoverColor;

  /// Color of the selected suggestion.
  /// Defaults to `Theme.of(context).highlightColor`.
  final Color? selectionColor;

  /// The elevation of the suggestion list.
  /// Defaults to `2.0`.
  final double? elevation;

  /// The shadow color of the suggestion list.
  final Color? shadowColor;

  /// The width of the suggestion menu from left to right.
  final double? width;

  const SuggestionDecoration({
    this.padding = EdgeInsets.zero,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 8),
    super.color,
    super.border,
    super.borderRadius,
    super.boxShadow,
    super.gradient,
    super.image,
    super.backgroundBlendMode,
    this.width,
    this.elevation,
    this.hoverColor,
    this.shadowColor,
    this.selectionColor,
    BoxShape shape = BoxShape.rectangle,
  }) : super(shape: shape);

  /// Merges another [SuggestionDecoration] into this one.
  SuggestionDecoration merge(SuggestionDecoration? other) {
    if (other == null) return this;
    return SuggestionDecoration(
      color: other.color ?? color,
      border: other.border ?? border,
      borderRadius: other.borderRadius ?? borderRadius,
      boxShadow: other.boxShadow ?? boxShadow,
      gradient: other.gradient ?? gradient,
      image: other.image ?? image,
      backgroundBlendMode: other.backgroundBlendMode ?? backgroundBlendMode,
      padding: other.padding,
      itemPadding: other.itemPadding,
      width: other.width ?? width,
      elevation: other.elevation ?? elevation,
      hoverColor: other.hoverColor ?? hoverColor,
      shadowColor: other.shadowColor ?? shadowColor,
      selectionColor: other.selectionColor ?? selectionColor,
      shape: other.shape,
    );
  }

  @override
  SuggestionDecoration copyWith({
    BlendMode? backgroundBlendMode,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Color? color,
    Gradient? gradient,
    DecorationImage? image,
    BoxShape? shape,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? itemPadding,
    double? width,
    double? elevation,
    Color? hoverColor,
    Color? shadowColor,
    Color? selectionColor,
  }) {
    return SuggestionDecoration(
      color: color ?? this.color,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
      gradient: gradient ?? this.gradient,
      image: image ?? this.image,
      backgroundBlendMode: backgroundBlendMode ?? this.backgroundBlendMode,
      shape: shape ?? this.shape,
      padding: padding ?? this.padding,
      itemPadding: itemPadding ?? this.itemPadding,
      width: width ?? this.width,
      elevation: elevation ?? this.elevation,
      hoverColor: hoverColor ?? this.hoverColor,
      shadowColor: shadowColor ?? this.shadowColor,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }
}

const kDefaultShapeBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(4),
    bottomRight: Radius.circular(4),
  ),
);

const double kDefaultElevation = 2.0;