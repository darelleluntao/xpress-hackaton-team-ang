import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';

class NedApp extends ConsumerWidget {
  const NedApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: FlavorConfig.instance.appName,
      theme: AppTheme.nedTheme,
      routerConfig: router,
    );
  }
}
