import 'package:flutter/material.dart';
import 'package:flutter_rapid_starter/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static String fontFamily = "Cairo";
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(primary: AppColors.primary),

    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: const TextStyle(color: AppColors.baseBlack),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.baseBlack,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        color: AppColors.baseBlack,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        color: AppColors.baseBlack,
        fontFamily: fontFamily,
      ),
      labelLarge:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      labelMedium:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      labelSmall:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      displayLarge:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      displayMedium:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      displaySmall:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      headlineLarge:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      headlineMedium:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      headlineSmall:
          TextStyle(color: AppColors.baseBlack, fontFamily: fontFamily),
      titleLarge:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      titleMedium:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
      titleSmall:
          TextStyle(fontFamily: fontFamily, color: AppColors.baseBlack),
    ),
    // Add more customizations as needed
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.darkBackground,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      titleTextStyle: TextStyle(color: AppColors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.white,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        color: AppColors.white,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        color: AppColors.white,
        fontFamily: fontFamily,
      ),
      labelLarge:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      labelMedium:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      labelSmall:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      displayLarge:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      displayMedium:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      displaySmall:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      headlineLarge:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      headlineMedium:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      headlineSmall:
      TextStyle(color: AppColors.white, fontFamily: fontFamily),
      titleLarge:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      titleMedium:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
      titleSmall:
      TextStyle(fontFamily: fontFamily, color: AppColors.white),
    ),
    // Add more customizations as needed
  );
}
