import 'package:flutter/material.dart';

class AppTheme {
  static const Color pink = Color(0xFFF6C1CC);
  static const Color mint = Color(0xFFC1E1DC);
  static const Color darkText = Color(0xFF3A3A3A);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Poppins',

    colorScheme: ColorScheme.fromSeed(
      seedColor: pink,
      primary: pink,
      secondary: mint,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: pink,
        foregroundColor: darkText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),
  );
}
