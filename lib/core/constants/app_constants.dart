import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // API
  static const String baseUrl = 'https://api.example.com/v1';

  // ScreenUtil design reference dimensions
  static const double designWidth = 360;
  static const double designHeight = 690;

  // Localization
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('fr'),
    Locale('es'),
    Locale('it'),
  ];
  static const Locale fallbackLocale = Locale('en');
  static const String translationsPath = 'assets/translations';
}
