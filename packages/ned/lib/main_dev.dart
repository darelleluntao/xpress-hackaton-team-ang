import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetIt service locator from core package
  await init();

  // Initialize flavor configuration
  FlavorConfig(
    flavor: Flavor.dev,
    name: 'Ned Dev',
    apiBaseUrl: 'https://api.dev.ned.com',
    appName: 'Ned Dev',
    appId: 'com.tengu.ned.dev',
  );

  runApp(
    const ProviderScope(
      child: NedApp(),
    ),
  );
}
