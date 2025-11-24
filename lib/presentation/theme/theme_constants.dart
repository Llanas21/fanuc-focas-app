import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    titleLarge: const TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: const TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: const TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(color: Colors.grey[400], fontSize: 28),
    labelSmall: TextStyle(color: Colors.grey[400], fontSize: 24),
    bodyMedium: const TextStyle(color: Colors.black, fontSize: 28),
    bodySmall: const TextStyle(color: Colors.black, fontSize: 24),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black, size: 28),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.indigo;
      }
      return Colors.grey;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      return Colors.white;
    }),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    filled: true,
    fillColor: Colors.grey[200],
    labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 14.0,
      vertical: 10.0,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.redAccent,
    contentTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
    // elevation: 0.0,
    behavior: SnackBarBehavior.floating,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.indigo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.indigo,
  ),
  dialogTheme: DialogThemeData(backgroundColor: Colors.white),
);
