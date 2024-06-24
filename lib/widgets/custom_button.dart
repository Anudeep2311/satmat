import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.myColorScheme,
      required this.buttonText,
      required this.onPressed});

  final ColorScheme myColorScheme;
  final Text buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(
            BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(myColorScheme.secondary),
          foregroundColor: WidgetStateProperty.all(myColorScheme.onPrimary),
        ),
        onPressed: onPressed,
        child: buttonText,
      ),
    );
  }
}
