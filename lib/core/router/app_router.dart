import 'package:easy_localization/easy_localization.dart';
import 'package:fitnies/features/auth/presentation/providers/auth_notifier.dart';
import 'package:fitnies/features/auth/presentation/screens/login_screen.dart';
import 'package:fitnies/features/onboarding/presentation/providers/onboarding_notifier.dart';
import 'package:fitnies/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:fitnies/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authNotifierProvider);
  final onboardingState = ref.watch(onboardingNotifierProvider);

  return GoRouter(
    initialLocation: SplashRoute.path,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isSplash = location == SplashRoute.path;
      final isOnboarding = location == OnboardingRoute.path;

      if (onboardingState.isLoading || onboardingState.hasError) {
        return isSplash ? null : SplashRoute.path;
      }

      final hasSeenOnboarding = onboardingState.valueOrNull ?? false;
      if (!hasSeenOnboarding) {
        return isOnboarding ? null : OnboardingRoute.path;
      }

      final isLoggedIn = authState.valueOrNull != null;
      final isLoggingIn = location == LoginRoute.path;

      if (isSplash || isOnboarding) {
        return isLoggedIn ? HomeRoute.path : LoginRoute.path;
      }

      if (!isLoggedIn && !isLoggingIn) {
        return LoginRoute.path;
      }

      if (isLoggedIn && isLoggingIn) {
        return HomeRoute.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: SplashRoute.path,
        name: SplashRoute.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: OnboardingRoute.path,
        name: OnboardingRoute.name,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: LoginRoute.path,
        name: LoginRoute.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: HomeRoute.path,
        name: HomeRoute.name,
        builder: (context, state) => const _AuthenticatedHomeScreen(),
      ),
    ],
  );
}

class SplashRoute {
  const SplashRoute._();

  static const path = '/splash';
  static const name = 'splash';
}

class OnboardingRoute {
  const OnboardingRoute._();

  static const path = '/onboarding';
  static const name = 'onboarding';
}

class LoginRoute {
  const LoginRoute._();

  static const path = '/login';
  static const name = 'login';
}

class HomeRoute {
  const HomeRoute._();

  static const path = '/';
  static const name = 'home';
}

class _AuthenticatedHomeScreen extends ConsumerWidget {
  const _AuthenticatedHomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Text('app.name'.tr()),
        actions: [
          IconButton(
            tooltip: 'home.logout'.tr(),
            onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          user == null
              ? 'auth.welcome'.tr()
              : 'auth.welcome_user'.tr(namedArgs: {'name': user.name}),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
