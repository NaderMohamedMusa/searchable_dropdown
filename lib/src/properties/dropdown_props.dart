import 'package:flutter/material.dart';

import 'icon_button_props.dart';

class DropdownButtonProps extends IconButtonProps {
  final Widget iconOpened;

  const DropdownButtonProps({
    this.iconOpened = const Icon(
      Icons.arrow_drop_up,
      size: 16,
    ),
    Widget iconClosed = const Icon(
      Icons.arrow_drop_down,
      size: 16,
    ),
    super.isVisible = true,
    super.iconSize,
    super.visualDensity,
    super.padding,
    super.alignment,
    super.splashRadius,
    super.color,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.disabledColor,
    super.mouseCursor,
    super.focusNode,
    super.autofocus,
    super.tooltip,
    super.enableFeedback,
    super.constraints,
    super.style,
    super.isSelected,
    super.selectedIcon,
  }) : super(icon: iconClosed);
}