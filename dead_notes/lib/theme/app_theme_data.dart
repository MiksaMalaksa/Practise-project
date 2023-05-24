import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData lightTheme({required MaterialColor primarySwatch, required Color primaryColor}) => ThemeData(
    fontFamily: 'Nunito',
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: primarySwatch,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xff3d5a80),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: const Color(0xff3d5a80),
      error: Colors.red,
      tertiary: Colors.deepPurpleAccent,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Color(0xff3d5a80),
        fontSize: 28.0,
        fontFamily: 'Nunito',
      ),
      titleMedium: TextStyle(
        color: Color(0xff3d5a80),
        fontSize: 16.0,
        fontFamily: 'Nunito',
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    ),
  );

  static ThemeData darkTheme({required MaterialColor primarySwatch, required Color primaryColor}) => ThemeData(
    fontFamily: 'Nunito',
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: primarySwatch,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: const Color(0xff3d5a80),
      error: Colors.red,
      tertiary: Colors.deepPurpleAccent,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontFamily: 'Nunito',
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: 'Nunito',
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    ),
  );
}