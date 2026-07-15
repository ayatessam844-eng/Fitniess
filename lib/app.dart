import 'package:fitnies/core/router/app_router.dart';
import 'package:fitnies/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'features/auth/presentation/providers/auth_notifier.dart';

class FitnessApp extends ConsumerStatefulWidget {
  const FitnessApp({super.key});
  @override
  ConsumerState<FitnessApp> createState() => _FitnessAppState();
}
class _FitnessAppState extends ConsumerState<FitnessApp> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(authNotifierProvider, (previous, next) {
      if (next.isLoading) {
        FlutterNativeSplash.remove();
      }
    }, fireImmediately: true
    );
  }
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'app.name'.tr(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      routerConfig: router,
    );
  }


}
