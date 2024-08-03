import 'package:flutter/material.dart';

import 'constants.dart';

TextTheme _responsiveTextTheme(
  BuildContext context,
  Color color,
  double screenWidth,
) {
  return TextTheme(
    bodyLarge: TextStyle(
      color: color,
      fontSize: screenWidth * 0.045,
      fontFamily: AppConstants.fontFamily,
    ),
    bodyMedium: TextStyle(
      color: color,
      fontSize: screenWidth * 0.04,
      fontFamily: AppConstants.fontFamily,
    ),
    bodySmall: TextStyle(
      color: color,
      fontSize: screenWidth * 0.035,
      fontFamily: AppConstants.fontFamily,
    ),
    titleLarge: TextStyle(
      color: color,
      fontSize: screenWidth * 0.045,
      fontFamily: AppConstants.fontFamily,
    ),
    titleMedium: TextStyle(
      color: color,
      fontSize: screenWidth * 0.04,
      fontFamily: AppConstants.fontFamily,
    ),
    titleSmall: TextStyle(
      color: color,
      fontSize: screenWidth * 0.035,
      fontFamily: AppConstants.fontFamily,
    ),
    labelLarge: TextStyle(
      color: color,
      fontSize: screenWidth * 0.045,
      fontFamily: AppConstants.fontFamily,
    ),
    labelMedium: TextStyle(
      color: color,
      fontSize: screenWidth * 0.04,
      fontFamily: AppConstants.fontFamily,
    ),
    labelSmall: TextStyle(
      color: color,
      fontSize: screenWidth * 0.035,
      fontFamily: AppConstants.fontFamily,
    ),
    displayLarge: TextStyle(
      color: color,
      fontSize: screenWidth * 0.04,
      fontFamily: AppConstants.fontFamily,
    ),
    displayMedium: TextStyle(
      color: color,
      fontSize: screenWidth * 0.04,
      fontFamily: AppConstants.fontFamily,
    ),
    displaySmall: TextStyle(
      color: color,
      fontSize: screenWidth * 0.035,
      fontFamily: AppConstants.fontFamily,
    ),
    headlineLarge: TextStyle(
      color: color,
      fontSize: screenWidth * 0.045,
      fontFamily: AppConstants.fontFamily,
    ),
    headlineMedium: TextStyle(
      color: color,
      fontSize: screenWidth * 0.04,
      fontFamily: AppConstants.fontFamily,
    ),
    headlineSmall: TextStyle(
      color: color,
      fontSize: screenWidth * 0.035,
      fontFamily: AppConstants.fontFamily,
    ),
  );
}

class AppThemes {
  static ThemeData lightTheme(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.lightBackgroundColor,
      iconTheme: const IconThemeData(
        color: AppColors.black,
        size: 15,
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.primaryColor,
        titleTextStyle: _responsiveTextTheme(
          context,
          AppColors.black,
          screenWidth,
        ).titleLarge,
        toolbarTextStyle: _responsiveTextTheme(
          context,
          AppColors.black,
          screenWidth,
        ).titleLarge,
      ),
      cardColor: AppColors.black,
      textTheme: _responsiveTextTheme(
        context,
        AppColors.black,
        screenWidth,
      ),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.darkPrimaryColor,
        secondary: AppColors.darkPrimaryColor,
        onPrimary: AppColors.black,
        onSecondary: AppColors.black,
        background: AppColors.darkBackgroundColor,
        surface: AppColors.grey,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ThemeData(
      primaryColor: AppColors.darkPrimaryColor,
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      appBarTheme: AppBarTheme(
        color: AppColors.darkPrimaryColor,
        titleTextStyle: _responsiveTextTheme(
          context,
          AppColors.white,
          screenWidth,
        ).titleLarge,
        toolbarTextStyle: _responsiveTextTheme(
          context,
          AppColors.white,
          screenWidth,
        ).titleLarge,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.white,
        size: 15,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.white,
        selectionColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.white,
      ),
      cardColor: AppColors.grey,
      textTheme: _responsiveTextTheme(
        context,
        AppColors.white,
        screenWidth,
      ),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.darkPrimaryColor,
        secondary: AppColors.darkPrimaryColor,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        background: AppColors.darkBackgroundColor,
        surface: AppColors.grey,
      ),
    );
  }
}
