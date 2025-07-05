import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/category_details_screen.dart';
import '../screens/service_provider_detail_screen.dart';
import '../screens/phone_login_screen.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
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
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/category/:name',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final extra = state.extra as Map<String, dynamic>?;
        return CategoryDetailsScreen(
          categoryName: name,
          categoryColor: extra?['color'] as Color? ?? Colors.grey,
        );
      },
    ),
    GoRoute(
      path: '/service-provider/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ServiceProviderDetailScreen(id: id);
      },
    ),
  ],
  redirect: (context, state) {
    // TODO: Implement authentication logic
    return null;
  },
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.error}'),
    ),
  ),
);
