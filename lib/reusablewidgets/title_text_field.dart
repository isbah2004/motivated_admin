import 'package:flutter/material.dart';
import 'package:motivated_admin/theme/theme_data.dart';

class ReusableTextField extends StatelessWidget {
  final FocusNode? currentFocusNode;
  final TextEditingController controller;
  final String hintAndLabelText;
  final Function(String)? onFieldSubmitted;

  const ReusableTextField(
      {super.key,
      this.currentFocusNode,
      required this.controller,
      required this.hintAndLabelText,
       this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Don\'t leave field empty';
          }
          return null;
        },
        focusNode: currentFocusNode,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintAndLabelText,
          labelText: hintAndLabelText,
          fillColor: AppTheme.textFieldFilledColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onFieldSubmitted: onFieldSubmitted,

      ),
    );
  }
}
