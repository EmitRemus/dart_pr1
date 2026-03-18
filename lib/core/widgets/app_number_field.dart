import 'package:flutter/material.dart';
import '../utils/number_parser.dart';

class AppNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? helperText;

  const AppNumberField({
    super.key,
    required this.controller,
    required this.label,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          helperText: helperText,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          final text = (value ?? '').trim();
          if (text.isEmpty) {
            return 'Required field';
          }

          if (NumberParser.tryParse(text) == null) {
            return 'Enter a valid number';
          }

          return null;
        },
      ),
    );
  }
}