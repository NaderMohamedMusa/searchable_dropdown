import 'package:flutter/material.dart';

class TooltipProps {
  /// The text style to use for the tooltip message.
  final TextStyle? textStyle;

  /// The decoration for the tooltip box.
  final Decoration? decoration;

  /// The height of the tooltip.
  final double? height;

  /// The padding inside the tooltip.
  final EdgeInsetsGeometry? padding;

  /// The margin around the tooltip.
  final EdgeInsetsGeometry? margin;

  /// The vertical gap between the tooltip and the target widget.
  final double? verticalOffset;

  /// Whether the tooltip should preferentially show below the target widget.
  final bool? preferBelow;

  /// Whether to exclude the tooltip from semantics.
  final bool? excludeFromSemantics;

  /// The length of time the tooltip will be shown after a long press.
  final Duration? showDuration;

  /// The length of time before the tooltip is shown after hovering.
  final Duration? waitDuration;

  /// Whether the tooltip should trigger on tap.
  final bool? triggerMode;

  /// Whether to enable feedback (vibration/sound) when tooltip is shown.
  final bool? enableFeedback;

  /// The alignment of the text within the tooltip.
  final TextAlign? textAlign;

  const TooltipProps({
    this.textStyle,
    this.decoration,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.showDuration,
    this.waitDuration,
    this.triggerMode,
    this.enableFeedback,
    this.textAlign,
  });
}