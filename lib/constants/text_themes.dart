import 'package:flutter/material.dart';
import 'text_styles.dart';

class AppTextThemes {
  static const TextTheme textTheme = TextTheme(
    displayLarge: AppTextStyles.headline1,
    displayMedium: AppTextStyles.headline2,
    displaySmall: AppTextStyles.headline3,
    bodyLarge: AppTextStyles.bodyText1,
    bodyMedium: AppTextStyles.bodyText2,
    labelLarge: AppTextStyles.buttonText,
    bodySmall: AppTextStyles.caption,
    titleMedium: AppTextStyles.subtitle1,
    titleSmall: AppTextStyles.subtitle2,
    labelSmall: AppTextStyles.overline,
  );
}
