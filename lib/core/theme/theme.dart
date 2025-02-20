import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818cf8);
  static const Color primaryDark = Color(0xFF3730A3);

  static const Color secondaryColor = Color(0xFFEC4899);
  static const Color tertiaryColor = Color(0xFF14B8A6);

  static const List<Color> primaryGradient = [
    primaryColor,
    Color(0xFF6366f1),
  ];

  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color surfaceColor = Color(0xFFF8FAFC);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);

  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: tertiaryColor,
          surface: surfaceColor,
          error: error,
        ),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: textPrimary,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: textSecondary,
            fontSize: 14,
          ),
        ));
  }
}
