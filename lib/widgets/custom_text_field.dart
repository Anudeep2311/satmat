import 'package:flutter/material.dart';
import 'package:newapp/theme/theme_data.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController controller,
    required this.labelText,
    required this.obscureText,
    this.textInputType,
    this.validator,
    this.onSaved,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String labelText;
  final bool obscureText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      controller: _controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: themeData.colorScheme.primary,
          ),
        ),
        labelText: labelText,
      ),
      obscureText: obscureText,
      keyboardType: textInputType,
    );
  }
}
