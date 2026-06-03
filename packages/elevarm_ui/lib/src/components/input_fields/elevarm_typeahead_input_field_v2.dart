import 'package:elevarm_icons/elevarm_icons.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:elevarm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ElevarmTypeaheadInputFieldV2<T> extends StatefulWidget {
  final Future<Iterable<T>> Function(String) suggestionsCallback;
  // final String Function(BuildContext, T) getItemTitle;
  final void Function(T) onSuggestionSelected;

  /// The label above the input field.
  final String? label;

  /// The error text if any.
  final String? errorText;

  /// The hint text.
  final String? hintText;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [InputDecoration.enabled] property.
  final bool enabled;

  /// Whether the field is required or not.
  final bool isRequired;

  final T? value;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// myFocusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field. The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling
  /// [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// The suffix icon asset name.
  final IconData suffixIconAssetName;

  final String Function(T?) getTitle;

  final void Function(String)? onEmpty;

  /// The helper text.
  final String? helperText;

  final String id;

  final ElevarmTextInputFieldSize size;

  final bool Function(T? a, T? b)? isEqual;

  const ElevarmTypeaheadInputFieldV2({
    required this.id,
    required this.suggestionsCallback,
    required this.onSuggestionSelected,
    required this.getTitle,
    this.hintText,
    super.key,
    this.enabled = true,
    this.errorText,
    this.label,
    this.value,
    this.isRequired = false,
    this.suffixIconAssetName = ElevarmIconsOutline.chevron_down,
    this.focusNode,
    this.onEmpty,
    this.helperText,
    this.size = ElevarmTextInputFieldSize.md,
    this.isEqual,
  });

  @override
  State<ElevarmTypeaheadInputFieldV2<T>> createState() =>
      _ElevarmTypeaheadInputFieldV2State<T>();
}

class _ElevarmTypeaheadInputFieldV2State<T>
    extends State<ElevarmTypeaheadInputFieldV2<T>> {
  bool _isFocused = false;
  late FocusNode _focusNode;
  int _internalId = 1;

  @override
  void initState() {
    super.initState();

    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
    }
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      if (!_focusNode.hasFocus) {
        setState(() {
          _internalId++;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry contentPadding;
    if (widget.size == ElevarmTextInputFieldSize.sm) {
      contentPadding = const EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: 12.0,
      );
    } else {
      contentPadding = const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 14.0,
      );
    }
    Color finalSuffixIconColor;
    IconData? suffixIcon;
    Widget? suffixWidget;
    if (widget.enabled && widget.errorText != null) {
      finalSuffixIconColor = ElevarmColors.danger;
      suffixIcon = ElevarmIconsOutline.alert_circle;
    } else {
      finalSuffixIconColor = ElevarmColors.neutral300;
      suffixIcon = widget.suffixIconAssetName;
    }
    suffixWidget = FittedBox(
      fit: BoxFit.scaleDown,
      child: IconButton(
        onPressed: null,
        icon: ElevarmIcon(
          suffixIcon,
          color: finalSuffixIconColor,
          size: 16.0,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? ElevarmInputFieldLabel(
                label: widget.label!,
                isRequired: widget.isRequired,
              )
            : const SizedBox(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: !_isFocused
                ? ElevarmBoxShadow.xs
                : [
                    const BoxShadow(
                      color: Color.fromRGBO(16, 24, 40, 0.05),
                      offset: Offset(1.0, 0.0),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: widget.errorText == null
                          ? const Color(0xFFEBF1FF)
                          : const Color(0xFFFEE4E2),
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 4.0,
                    ),
                  ],
          ),
          child: TypeAheadFormField<T>(
            key: Key(
              'input-typeahead-${widget.id}-${widget.value}-$_internalId',
            ),
            enabled: widget.enabled,
            initialValue: widget.getTitle(widget.value),
            suggestionsCallback: widget.suggestionsCallback,
            noItemsFoundBuilder: (context) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    bottom: 12.0,
                    right: 10.0,
                    left: 8.0,
                  ),
                  child: Text(
                    'Pencarian tidak ditemukan',
                    textAlign: TextAlign.center,
                    style: LibraryTextStyles.interSmRegularNeutral300,
                  ),
                ),
              );
            },
            errorBuilder: (context, error) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    bottom: 12.0,
                    right: 10.0,
                    left: 8.0,
                  ),
                  child: Text(
                    'Error: $error',
                    style: LibraryTextStyles.interSmRegularDanger,
                  ),
                ),
              );
            },
            itemBuilder: (context, item) {
              late bool isSelected;
              if (widget.isEqual != null) {
                isSelected = widget.isEqual!(item, widget.value);
              } else {
                isSelected = item == widget.value;
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: isSelected ? ElevarmColors.neutral50 : null,
                  ),
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    bottom: 12.0,
                    right: 10.0,
                    left: 8.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.getTitle(item),
                          style: LibraryTextStyles.interMdMediumNeutral,
                        ),
                      ),
                      if (isSelected)
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: ElevarmIcon(
                            ElevarmIconsOutline.check,
                            color: ElevarmColors.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
            onSuggestionSelected: widget.onSuggestionSelected,
            textFieldConfiguration: TextFieldConfiguration(
              style: LibraryTextStyles.interMdRegularNeutral,
              cursorColor: widget.errorText == null
                  ? ElevarmColors.primary
                  : ElevarmColors.danger,
              enabled: widget.enabled,
              focusNode: _focusNode,
              onSubmitted: (value) {
                if (value.isEmpty) {
                  widget.onEmpty!(value);
                }
              },
              decoration: InputDecoration(
                isDense: true,
                counterText: '',
                contentPadding: contentPadding,
                fillColor: widget.enabled
                    ? ElevarmColors.white
                    : ElevarmColors.neutral50,
                filled: true,
                hintText: widget.hintText,
                hintStyle: LibraryTextStyles.interMdRegularNeutral300,
                border: widget.errorText == null
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ElevarmColors.neutral100,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      )
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ElevarmColors.danger300,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                enabledBorder: widget.errorText == null
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ElevarmColors.neutral100,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      )
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ElevarmColors.danger300,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ElevarmColors.neutral100,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: widget.errorText == null
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ElevarmColors.primary200,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      )
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ElevarmColors.danger300,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                // prefixIcon: prefixWidget,
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0.0,
                  minHeight: 0.0,
                ),
                suffixIcon: suffixWidget,
              ),
            ),
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              color: ElevarmColors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  // ignore: deprecated_member_use_from_same_package
                  color: ElevarmColors.grey200,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
              ),
            ),
          ),
        ),
        widget.helperText != null &&
                (widget.errorText == null || !widget.enabled)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6.0),
                  Text(
                    widget.helperText!,
                    style: LibraryTextStyles.interXsRegularNeutral300,
                  ),
                ],
              )
            : const SizedBox(),
        widget.errorText != null && widget.enabled
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6.0),
                  Text(
                    widget.errorText!,
                    style: LibraryTextStyles.interXsRegularDanger,
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
