import 'package:flutter/material.dart';

class ScrollbarProps {
  final ScrollbarDecoration? scrollbarDecoration;
  final ShapeBorder? shape;
  final double? radius;
  final double? thickness;
  final double? mainAxisMargin;
  final double? crossAxisMargin;
  final Duration? fadeDuration;
  final Duration? timeToFade;
  final Duration pressDuration;
  final Color? trackBorderColor;
  final Color? trackColor;
  final Color? thumbColor;
  final double minThumbLength;
  final double? minOverscrollLength;
  final double? trackRadius;
  final Axis? scrollbarOrientation;
  final bool? thumbVisibility;
  final bool? trackVisibility;
  final bool? interactive;
  final ScrollNotificationPredicate? notificationPredicate;
  final EdgeInsets? padding;

  const ScrollbarProps({
    this.scrollbarDecoration,
    this.shape,
    this.radius,
    this.thickness,
    this.mainAxisMargin = 0.0,
    this.crossAxisMargin = 0.0,
    this.fadeDuration = const Duration(milliseconds: 300),
    this.timeToFade = const Duration(milliseconds: 600),
    this.pressDuration = Duration.zero,
    this.trackBorderColor,
    this.trackColor,
    this.thumbColor,
    this.minThumbLength = 18.0,
    this.minOverscrollLength,
    this.trackRadius,
    this.scrollbarOrientation,
    this.thumbVisibility,
    this.trackVisibility,
    this.interactive,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.padding = EdgeInsets.zero,
  });

  static bool defaultScrollNotificationPredicate(
      ScrollNotification notification,
      ) {
    return notification.depth == 0;
  }

  /// Merges explicit [ScrollbarProps] fields over [ScrollbarProps].
  ScrollbarDecoration mergeScrollbarDecoration(
      ScrollbarProps props,
      ) {
    final base =
        props.scrollbarDecoration ?? const ScrollbarDecoration();

    return ScrollbarDecoration(
      thumbVisibility: props.thumbVisibility ?? base.thumbVisibility,
      thickness: props.thickness ?? base.thickness,
      radius: props.radius ?? base.radius,
      shape: props.shape ?? base.shape,
      thumbColor: props.thumbColor ?? base.thumbColor,
      trackVisibility: props.trackVisibility ?? base.trackVisibility,
      trackRadius: props.trackRadius ?? base.trackRadius,
      trackColor: props.trackColor ?? base.trackColor,
      trackBorderColor:
      props.trackBorderColor ?? base.trackBorderColor,
      fadeDuration: props.fadeDuration,
      timeToFade: props.timeToFade,
      pressDuration: props.pressDuration,
      crossAxisMargin: props.crossAxisMargin,
      minThumbLength: props.minThumbLength,
      orientation:
      props.scrollbarOrientation ?? base.orientation,
      interactive: props.interactive ?? base.interactive,
    );
  }
}