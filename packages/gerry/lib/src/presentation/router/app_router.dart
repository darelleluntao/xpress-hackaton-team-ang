import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/phone_login_screen.dart';
import '../screens/otp_screen.dart';
import '../screens/home_screen.dart';

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
      final isLoginPath = state.matchedLocation == '/login';
      final isPhoneLoginPath = state.matchedLocation == '/phone-login';
      final isOtpPath = state.matchedLocation == '/otp';

      // If trying to access auth-related pages when already logged in, redirect to home
      if (isLoggedIn && (isLoginPath || isPhoneLoginPath || isOtpPath)) {
        return '/home';
      }

      // If not logged in and not on an auth page or splash, redirect to phone-login
      if (!isLoggedIn &&
          !isLoginPath &&
          !isPhoneLoginPath &&
          !isOtpPath &&
          !isSplash) {
        return '/phone-login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/phone-login',
        builder: (context, state) => const PhoneLoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final phoneNumber = state.extra as String?;
          if (phoneNumber == null) {
            return const PhoneLoginScreen();
          }
          return OtpScreen(phoneNumber: phoneNumber);
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      // Additional routes for bottom navigation sections
      GoRoute(
        path: '/orders',
        builder: (context, state) =>
            const HomeScreen(), // Uses the same HomeScreen with different tab
      ),
      GoRoute(
        path: '/discover',
        builder: (context, state) =>
            const HomeScreen(), // Uses the same HomeScreen with different tab
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) =>
            const HomeScreen(), // Uses the same HomeScreen with different tab
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
