import 'package:flutter/material.dart';

class AppLocalization {
  const AppLocalization._();

  static const path = 'assets/translations';
  static const english = Locale('en');
  static const arabic = Locale('ar');
  static const fallbackLocale = english;
  static const supportedLocales = [english, arabic];
}
