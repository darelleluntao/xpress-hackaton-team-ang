import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';

class GerryApp extends ConsumerWidget {
  const GerryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: FlavorConfig.instance.appName,
      theme: AppTheme.gerryTheme,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
