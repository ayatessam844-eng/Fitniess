import 'package:easy_localization/easy_localization.dart';
import 'package:fitnies/features/auth/presentation/providers/auth_notifier.dart';
import 'package:fitnies/features/auth/presentation/screens/login_screen.dart';
import 'package:fitnies/features/auth/presentation/screens/register_screen.dart';
import 'package:fitnies/features/onboarding/presentation/providers/onboarding_notifier.dart';
import 'package:fitnies/features/onboarding/presentation/screens/onboarding_screen.dart';
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
    initialLocation: OnboardingRoute.path,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isOnboarding = location == OnboardingRoute.path;

      // still loading onboarding flag -> stay put, don't redirect yet
      if (onboardingState.isLoading || onboardingState.hasError) {
        return null;
      }

      final hasSeenOnboarding = onboardingState.valueOrNull ?? false;
      if (!hasSeenOnboarding) {
        return isOnboarding ? null : OnboardingRoute.path;
      }

      final isLoggedIn = authState.valueOrNull != null;

      // Routes that should be reachable WITHOUT being logged in
      final isPublicRoute =
          location == LoginRoute.path || location == RegisterRoute.path;

      // if (isOnboarding) {
      //   return isLoggedIn ? HomeRoute.path : LoginRoute.path;
      // }

      if (!isLoggedIn && !isPublicRoute) {
        return LoginRoute.path;
      }

      // if (isLoggedIn && isPublicRoute) {
      //   return HomeRoute.path;
      // }

      return null;
    },
    routes: [
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
          path: RegisterRoute.path,
          name: RegisterRoute.name,
          builder: (context, state) => const RegisterScreen()
      ),
      // GoRoute(
      //   path: HomeRoute.path,
      //   name: HomeRoute.name,
      //   builder: (context, state) => const _AuthenticatedHomeScreen(),
      // ),
    ],
  );
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
class RegisterRoute{
  const RegisterRoute._();
  static const path = '/register';
  static const name = 'register';
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