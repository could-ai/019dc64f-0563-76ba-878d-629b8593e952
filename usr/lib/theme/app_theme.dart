import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFF09A36), // Vibrant Orange for operators
        onPrimary: Colors.white,
        secondaryContainer: Color(0xFFD4D4D2), // Light gray for actions (AC, +/-, %)
        onSecondaryContainer: Colors.black,
        surfaceContainerHighest: Color(0xFFE0E0E0), // Medium gray for numbers
        onSurface: Colors.black,
        surface: Color(0xFFF3F3F3), // App background
      ),
      scaffoldBackgroundColor: const Color(0xFFF3F3F3),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFF9F0A), // iOS-like Orange for operators
        onPrimary: Colors.white,
        secondaryContainer: Color(0xFFA5A5A5), // Light gray for actions
        onSecondaryContainer: Colors.black,
        surfaceContainerHighest: Color(0xFF333333), // Dark gray for numbers
        onSurface: Colors.white,
        surface: Colors.black, // App background
      ),
      scaffoldBackgroundColor: Colors.black,
    );
  }
}
