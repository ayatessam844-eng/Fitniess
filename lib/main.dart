import 'package:fitnies/app.dart';
import 'package:fitnies/core/localization/app_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalization.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: AppLocalization.fallbackLocale,
      child: const ProviderScope(child: FitnessApp()),
    ),
  );
}
