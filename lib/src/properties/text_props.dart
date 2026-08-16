import 'package:flutter/material.dart';

import '../utils/input_decoration.dart';
import '../utils/typedef_data_type.dart';
import 'suffix_props.dart';

/// Inner [TextFormField] configuration for [SearchableDropdown].
///
/// This class contains text-field-specific configuration such as:
/// - validation
/// - keyboard behavior
/// - focus behavior
/// - formatting
/// - search callbacks
/// - decoration
/// - committed-selection rendering
///
/// Menu/list behavior remains in [MenuProps].
class TextProps<T> {
  /// Defines whether to enable the text field.
  ///
  /// Defaults to `true` when null.
  final bool? enabled;

  /// When true, the field is read-only.
  final bool readOnly;

  /// See [TextField.buildCounter].
  ///
  /// Used together with [MenuProps.maxLength].
  final InputCounterWidgetBuilder? buildCounter;

  /// See [TextFormField.autovalidateMode].
  final AutovalidateMode? autoValidateMode;

  /// Called when the user submits the field using the keyboard.
  final void Function(String value)? onSubmit;

  /// Called whenever the search/filter text changes.
  final ValueChanged<String>? onSearchTextChanged;

  /// When non-null and returns `true`, Tab submission does not
  /// advance focus to the next control.
  ///
  /// Useful when [onSubmit] rejects the submitted value.
  final bool Function(String submittedValue)? suppressTabSubmitFocusAdvance;

  /// See [TextField.onEditingComplete].
  final VoidCallback? onEditingComplete;

  /// See [TextField.textInputAction].
  final TextInputAction? textInputAction;

  /// Decoration and styles for the search input.
  ///
  /// When null, [SearchableDropdown] uses its internal default.
  final SearchInputDecoration? searchInputDecoration;

  /// Optional controller for the search field.
  ///
  /// When null, [SearchableDropdown] creates and owns its controller.
  final TextEditingController? controller;

  /// See [TextField.keyboardType].
  final TextInputType? inputType;

  /// Validator for the committed selection.
  ///
  /// The generic type matches the enclosing [SearchableDropdown]<T>.
  final FormFieldValidator<T>? validator;

  /// Optional validation for the raw search text.
  ///
  /// Runs after [validator] when both are provided.
  final String? Function(String?)? textValidator;

  /// See [TextFormField.onSaved].
  final void Function(String?)? onSaved;

  /// See [TextField.onTap].
  final VoidCallback? onTap;

  /// Controls whether suggestions can be opened from the text field.
  ///
  /// When non-null and returns `false`, the suggestion overlay will
  /// not be opened or attached.
  final bool Function()? canOpenSuggestions;

  /// See [TextField.autocorrect].
  final bool autoCorrect;

  /// See [TextField.textAlign].
  final TextAlign textAlign;

  /// See [TextField.contextMenuBuilder].
  final Widget Function(
      BuildContext,
      EditableTextState,
      )? contextMenuBuilder;

  /// See [TextField.autofocus].
  final bool autofocus;

  /// See [TextField.onTapOutside].
  final void Function(PointerDownEvent)? onTapOutside;

  /// See [TextField.inputFormatters].
  final List<TextInputFormatter>? inputFormatters;

  /// When false, selecting a suggestion replaces the field text
  /// with the selected item's label.
  ///
  /// When true, the entered search text is preserved.
  final bool keepSearchOnSelection;

  /// Trailing actions for the search field.
  ///
  /// Contains clear and dropdown/open-toggle configuration.
  final SuffixProps suffixProps;

  /// Builder used to render the committed selection when the
  /// suggestion field is closed.
  ///
  /// Must match the generic type of [SearchableDropdown].
  final SearchableDropdownBuilder<dynamic>? selectedItemBuilder;

  const TextProps({
    this.enabled,
    this.readOnly = false,
    this.buildCounter,
    this.autoValidateMode,
    this.onSubmit,
    this.onSearchTextChanged,
    this.suppressTabSubmitFocusAdvance,
    this.onEditingComplete,
    this.textInputAction,
    this.searchInputDecoration,
    this.controller,
    this.inputType,
    this.validator,
    this.textValidator,
    this.onSaved,
    this.onTap,
    this.canOpenSuggestions,
    this.autoCorrect = true,
    this.textAlign = TextAlign.start,
    this.contextMenuBuilder,
    this.autofocus = false,
    this.onTapOutside,
    this.inputFormatters,
    this.keepSearchOnSelection = false,
    this.suffixProps = const SuffixProps(),
    this.selectedItemBuilder,
  });

  TextProps<T> copyWith({
    bool? enabled,
    bool? readOnly,
    InputCounterWidgetBuilder? buildCounter,
    AutovalidateMode? autoValidateMode,
    void Function(String value)? onSubmit,
    ValueChanged<String>? onSearchTextChanged,
    bool Function(String submittedValue)?
    suppressTabSubmitFocusAdvance,
    VoidCallback? onEditingComplete,
    TextInputAction? textInputAction,
    SearchInputDecoration? searchInputDecoration,
    TextEditingController? controller,
    TextInputType? inputType,
    FormFieldValidator<T>? validator,
    String? Function(String?)? textValidator,
    void Function(String?)? onSaved,
    VoidCallback? onTap,
    bool Function()? canOpenSuggestions,
    bool? autoCorrect,
    TextAlign? textAlign,
    Widget Function(
        BuildContext,
        EditableTextState,
        )? contextMenuBuilder,
    bool? autofocus,
    void Function(PointerDownEvent)? onTapOutside,
    List<TextInputFormatter>? inputFormatters,
    bool? keepSearchOnSelection,
    SuffixProps? suffixProps,
    SearchableDropdownBuilder<dynamic>? selectedItemBuilder,
  }) {
    return TextProps<T>(
      enabled: enabled ?? this.enabled,
      readOnly: readOnly ?? this.readOnly,
      buildCounter: buildCounter ?? this.buildCounter,
      autoValidateMode:
      autoValidateMode ?? this.autoValidateMode,
      onSubmit: onSubmit ?? this.onSubmit,
      onSearchTextChanged:
      onSearchTextChanged ?? this.onSearchTextChanged,
      suppressTabSubmitFocusAdvance:
      suppressTabSubmitFocusAdvance ??
          this.suppressTabSubmitFocusAdvance,
      onEditingComplete:
      onEditingComplete ?? this.onEditingComplete,
      textInputAction:
      textInputAction ?? this.textInputAction,
      searchInputDecoration:
      searchInputDecoration ?? this.searchInputDecoration,
      controller: controller ?? this.controller,
      inputType: inputType ?? this.inputType,
      validator: validator ?? this.validator,
      textValidator: textValidator ?? this.textValidator,
      onSaved: onSaved ?? this.onSaved,
      onTap: onTap ?? this.onTap,
      canOpenSuggestions:
      canOpenSuggestions ?? this.canOpenSuggestions,
      autoCorrect: autoCorrect ?? this.autoCorrect,
      textAlign: textAlign ?? this.textAlign,
      contextMenuBuilder:
      contextMenuBuilder ?? this.contextMenuBuilder,
      autofocus: autofocus ?? this.autofocus,
      onTapOutside: onTapOutside ?? this.onTapOutside,
      inputFormatters:
      inputFormatters ?? this.inputFormatters,
      keepSearchOnSelection:
      keepSearchOnSelection ??
          this.keepSearchOnSelection,
      suffixProps:
      suffixProps ?? this.suffixProps,
      selectedItemBuilder:
      selectedItemBuilder ?? this.selectedItemBuilder,
    );
  }
}