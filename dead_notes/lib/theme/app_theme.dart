import 'package:flutter/material.dart';

class AppTheme {
  ThemeMode mode;
  IconData icon;

  AppTheme({
    required this.mode,
    required this.icon,
  });
}

List<AppTheme> appThemes = [
  AppTheme(
    mode: ThemeMode.light,
    icon: Icons.brightness_5_rounded,
  ),
  AppTheme(
    mode: ThemeMode.dark,
    icon: Icons.brightness_2_rounded,
  ),
  AppTheme(
    mode: ThemeMode.system,
    icon: Icons.brightness_4_rounded,
  ),
];