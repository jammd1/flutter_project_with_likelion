import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.lightBlueAccent;
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFE0E0E0);
  static const Color darkError = Color(0xFFCF6679);

  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        cardColor: Colors.white,
        drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),
        ),
      );

  static ThemeData get dark => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: darkBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: darkSurface,
          surfaceTintColor: darkSurface,
          titleTextStyle: TextStyle(
            color: darkText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: IconThemeData(color: darkText),
        ),
        cardColor: darkSurface,
        drawerTheme: DrawerThemeData(backgroundColor: darkSurface),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: darkText),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: darkText),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: darkText),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey[500]),
        ),
      );
}
