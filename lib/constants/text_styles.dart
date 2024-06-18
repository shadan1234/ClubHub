import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 96.0,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 60.0,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 48.0,
    color: AppColors.primaryText,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16.0,
    color: AppColors.secondaryText,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16.0,
    color: AppColors.primaryText,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14.0,
    color: AppColors.secondaryText,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    color: AppColors.secondaryText,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: AppColors.primary,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10.0,
    color: AppColors.secondaryText,
  );

  // Onboarding specific styles
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static const TextStyle onboardingDescription = TextStyle(
    fontSize: 16.0,
    color: AppColors.secondaryText,
  );
}
