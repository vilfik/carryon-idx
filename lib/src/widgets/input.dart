import 'package:flutter/material.dart';

class ClInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autoFocus;
  final bool autocorrect;
  final bool autofocus;
  final bool focusNext;
  final String? suffix;

  const ClInput({
    required this.controller,
    required this.hint,
    this.inputType = TextInputType.text,
    this.focusNext = false,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.autocorrect = true,
    this.autofocus = false,
    this.suffix,
    super.key,
  });

  // position suffix at the end of the input field somewhat like absolute positioning

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          autofocus: autofocus,
          autocorrect: autocorrect,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fillColor: Colors.grey[900],
            filled: true,
            suffixText: suffix,
            suffixStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          onEditingComplete: () {
            if (focusNext) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
