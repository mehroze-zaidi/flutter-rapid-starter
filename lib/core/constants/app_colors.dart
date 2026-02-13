import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xff4F83EA);
  static const Color primary50 = Color(0xffedf3fd);

  // ── Semantic states ───────────────────────────────────────────────────────
  static const Color error = Color(0xffFF6767);
  static const Color error50 = Color(0xffF7E6E6);
  static const Color success = Color(0xff27BE69);
  static const Color success50 = Color(0xffE6FAEE);
  static const Color warning = Color(0xffFFBF0F);
  static const Color info = Color(0xff295BFF);
  static const Color info50 = Color(0xffEBEFFF);

  // ── Absolute ──────────────────────────────────────────────────────────────
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color baseBlack = Color(0xff030712);

  // ── Surfaces ──────────────────────────────────────────────────────────────
  static const Color surfaceWhite = Color(0xffF8F7F7);
  static const Color darkBackground = Color(0xff0F1419);
  static const Color darkCardBackground = Color(0xff161D2A);

  // ── Typography ────────────────────────────────────────────────────────────
  static const Color headingText = Color(0xff001A4F);
  static const Color labelText = Color(0xff6E6E6E);
  static const Color textParagraph = Color(0xff6F6F6F);
  static const Color hintColor = Color(0xFFE7E7E7);

  // ── Neutral scale ─────────────────────────────────────────────────────────
  static const Color natural100 = Color(0xffE6E6E9);
  static const Color natural300 = Color(0xffBFC1C7);
  static const Color natural500 = Color(0xff8C8F9A);
  static const Color natural700 = Color(0xff404557);
  static const Color natural950 = Color(0xff00071F);

  // ── UI elements ───────────────────────────────────────────────────────────
  static const Color stroke = Color(0xffC3C0C6);
  static const Color buttonStroke = Color(0xffE6E6E6);
  static const Color inputSurface = Color(0xfff4f4f4);
}

// Extension for theme-aware colors
extension AppColorExtension on BuildContext {
  AppColorScheme get colors => AppColorScheme(this);
}

class AppColorScheme {
  final BuildContext context;

  AppColorScheme(this.context);

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  // Backgrounds
  Color get backgroundMain =>
      isDark ? AppColors.darkBackground : AppColors.surfaceWhite;
  Color get backgroundMainWhite =>
      isDark ? AppColors.darkBackground : Colors.white;
  Color get backgroundCard =>
      isDark ? AppColors.darkCardBackground : AppColors.surfaceWhite;
  Color get backgroundCardWhite =>
      isDark ? AppColors.darkCardBackground : Colors.white;

  // Contrast
  Color get opposite => isDark ? AppColors.white : AppColors.black;
  Color get theme => isDark ? AppColors.black : AppColors.white;

  // Text
  Color get headingText =>
      isDark ? const Color(0xffE8EEFF) : AppColors.headingText;
  Color get bodyText =>
      isDark ? const Color(0xffC4C6CC) : AppColors.textParagraph;
  Color get grayText =>
      isDark ? const Color(0xffA0A6B0) : AppColors.natural700;

  // UI elements
  Color get buttonStroke =>
      isDark ? const Color(0xff3A3F4D) : AppColors.buttonStroke;
  Color get stroke =>
      isDark ? const Color(0xff2A3040) : AppColors.stroke;
  Color get primary50 =>
      isDark ? AppColors.darkCardBackground : AppColors.primary50;
  Color get natural100 =>
      isDark ? const Color(0xff1C2331) : AppColors.natural100;
}
