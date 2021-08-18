import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData custom({
    required BuildContext context,
    required Color primaryColor,
    required scaffoldBackgroundColor,
    required Color appBarColor,
    required Color textColor,
  }) {
    return ThemeData(
      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      primaryColor: primaryColor,
      textTheme:
          TextTheme().apply(displayColor: textColor, bodyColor: textColor),
      appBarTheme: AppBarTheme(
        color: appBarColor,
      ),
    );
  }

  static ThemeData light(BuildContext context) {
    return custom(
        context: context,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.lightBackgroundColor,
        appBarColor: AppColors.lightAppBarColor,
        textColor: AppColors.lightTextColor);
  }

  static ThemeData dark(BuildContext context) {
    return custom(
        context: context,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.darkBackgroundColor,
        appBarColor: AppColors.darkAppBarColor,
        textColor: AppColors.darkTextColor);
  }
}
