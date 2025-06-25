import 'package:flutter/material.dart';

class ZaytooonTheme {
  static const Color primary = Color(0xFF5B9821);   // أخضر زيتوني
  static const Color secondary = Color(0xFFF28C28); // برتقالي دافئ
  static const Color darkText = Color(0xFF2C2C2C);  // رمادي داكن
  static const Color background = Color(0xFFF5F5F5);// خلفية فاتحة جدًا
  static const Color accent = Color(0xFFE4C062);    // أصفر زيتوني

  static ThemeData get theme {
    return ThemeData(
      fontFamily: "Cairo",
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        background: background,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: darkText,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: darkText),
        bodyMedium: TextStyle(color: darkText),
        bodySmall: TextStyle(color: darkText),
        labelLarge: TextStyle(color: darkText),
      ),
    );
  }
}