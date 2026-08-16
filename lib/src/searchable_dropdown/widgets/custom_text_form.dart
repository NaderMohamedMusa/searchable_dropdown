import 'package:searchable_dropdown/src/properties/text_props.dart';
import 'package:searchable_dropdown/src/utils/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Inner [TextFormField] for [SearchableDropdown]: decoration, validation
/// are supplied by the parent state.
class CustomTextForm<T> extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.formFieldKey,
    required this.textFieldProps,
    required this.maxLength,
    required this.maxLengthEnforcement,
    required this.controller,
    required this.focusNode,
    required this.decoration,
    required this.validator,
    required this.onChanged,
    required this.onEditingComplete,
    required this.onFieldSubmitted,
    required this.onFieldTap,
    this.readOnlyOverride,
  });

  final Key formFieldKey;
  /// When non-null, replaces [TextProps.readOnly] (e.g. menu-level selection)
  final bool? readOnlyOverride;
  final TextProps<T> textFieldProps;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final SearchInputDecoration decoration;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onFieldTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formFieldKey,
      contextMenuBuilder: (BuildContext context, EditableTextState state) {
        if (textFieldProps.contextMenuBuilder != null) {
          return textFieldProps.contextMenuBuilder!(context, state);
        }
        return AdaptiveTextSelectionToolbar.editableText(
          editableTextState: state,
        );
      },
      enabled: textFieldProps.enabled,
      textAlign: textFieldProps.textAlign,
      autofocus: textFieldProps.autofocus,
      autocorrect: textFieldProps.autoCorrect,
      readOnly: readOnlyOverride ?? textFieldProps.readOnly,
      autovalidateMode: textFieldProps.autoValidateMode,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onFieldTap,
      onSaved: textFieldProps.onSaved,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      buildCounter: textFieldProps.buildCounter,
      inputFormatters: textFieldProps.inputFormatters,
      controller: controller,
      focusNode: focusNode,
      cursorErrorColor: decoration.cursorErrorColor,
      cursorHeight: decoration.cursorHeight,
      cursorWidth: decoration.cursorWidth ?? 2.0,
      cursorOpacityAnimates: decoration.cursorOpacityAnimates,
      cursorRadius: decoration.cursorRadius,
      keyboardAppearance: decoration.keyboardAppearance,
      validator: validator,
      style: decoration.searchStyle,
      textInputAction: textFieldProps.textInputAction,
      textCapitalization: decoration.textCapitalization,
      keyboardType: textFieldProps.inputType,
      cursorColor: decoration.cursorColor,
      decoration: decoration,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }
}

/// Stacks the closed-field selection overlay on top of the child widget
class SearchableDropdownClosedSelectionStack extends StatelessWidget {
  const SearchableDropdownClosedSelectionStack({
    super.key,
    required this.child,
    required this.showOverlay,
    required this.onOverlayTap,
    required this.overlayBuilder,
    required this.overlayArgument,
  });

  final Widget child;
  final bool showOverlay;
  final VoidCallback onOverlayTap;
  final Widget Function(BuildContext context, dynamic selected) overlayBuilder;
  final dynamic overlayArgument;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        child,
        if (showOverlay)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onOverlayTap,
              child: overlayBuilder(context, overlayArgument),
            ),
          ),
      ],
    );
  }
}