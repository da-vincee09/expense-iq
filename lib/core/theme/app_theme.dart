import 'package:expense_iq/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Application theme configuration.
///
/// Defines light and dark ThemeData using centralized colors
/// and typography to maintain a consistent design system.
class AppTheme {

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTextTheme.textTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,

    textTheme: AppTextTheme.textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}