import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(userNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.maybeWhen(
        success: (_) => true,
        orElse: () => false,
      );

      final isSplash = state.matchedLocation == '/';
      final isLogin = state.matchedLocation == '/login';

      // If not logged in and not on login page, redirect to login
      if (!isLoggedIn && !isLogin && !isSplash) {
        return '/login';
      }

      // If logged in and on login page, redirect to home
      if (isLoggedIn && isLogin) {
        return '/home';
      }

      // No redirection needed
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        // builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        // builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        // builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found: ${state.matchedLocation}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    ),
  );
});
