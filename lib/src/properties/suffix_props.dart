import 'package:flutter/material.dart';

import 'clear_button_props.dart';
import 'dropdown_props.dart';

/// Trailing actions for [SearchableDropdown]: clear and open/toggle suffix.
class SuffixProps {
  final ClearButtonProps clearButtonProps;
  final DropdownButtonProps dropdownButtonProps;
  final TextDirection? direction;

  const SuffixProps({
    this.clearButtonProps = const ClearButtonProps(),
    this.dropdownButtonProps =
    const DropdownButtonProps(isVisible: false),
    this.direction = TextDirection.ltr,
  });
}