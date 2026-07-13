import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_router.dart';
import 'app_routes.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

import '../../features/auth/presentation/providers/auth_notifier.dart';


@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    // initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(ref), // see helper below
    redirect: (context, state) {
      // final loggedIn = authState.valueOrNull?.isLoggedIn ?? false;
      final loc = state.matchedLocation;

      // final isSplash = loc == AppRoutes.splash;
      final isOnboarding = loc == AppRoutes.onboarding;
      final isAuthRoute = loc.startsWith('/auth');

      // if (isSplash) return null; // splash decides itself
      //
      // if (!loggedIn && !isAuthRoute && !isOnboarding) {
      //   return AppRoutes.login;
      // }
      // if (loggedIn && isAuthRoute) {
      //   return AppRoutes.home;
      // }
      return null;
    },
    routes: [
      // GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashScreen()),
      GoRoute(path: AppRoutes.onboarding, builder: (_, __) => const OnboardingScreen()),

      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      // GoRoute(path: AppRoutes.register, builder: (_, __) => const RegisterScreen()),
      // GoRoute(path: AppRoutes.forgetPassword, builder: (_, __) => const ForgetPasswordScreen()),
      // GoRoute(path: AppRoutes.changePassword, builder: (_, __) => const ChangePasswordScreen()),
      //
      // GoRoute(path: AppRoutes.home, builder: (_, __) => const HomeScreen()),
      // GoRoute(path: AppRoutes.workout, builder: (_, __) => const WorkoutCategoriesScreen()),
      // GoRoute(path: AppRoutes.chatAi, builder: (_, __) => const ChatScreen()),
      // GoRoute(path: AppRoutes.profile, builder: (_, __) => const ProfileScreen()),
    ],
  );
}

/// Makes GoRouter listen to a Riverpod provider (auth state) and refresh.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Ref ref) {
    ref.listen(authNotifierProvider, (_, __) => notifyListeners());
  }
}