import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_themes.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: AppColors.primary,
    hintColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTextThemes.textTheme, colorScheme: const ColorScheme(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
      onPrimary: AppColors.background,
      onSecondary: AppColors.background,
      onSurface: AppColors.primaryText,
      onBackground: AppColors.primaryText,
      onError: AppColors.background,
      brightness: Brightness.light,
    ).copyWith(background: AppColors.background).copyWith(error: AppColors.error),
  );
}
