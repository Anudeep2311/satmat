import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 22,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.deepPurple,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.deepPurple.shade600,
    onPrimary: Colors.white,
    secondary: Colors.purple,
    onSecondary: Colors.black38,
    error: Colors.red,
    onError: Colors.red,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
);
