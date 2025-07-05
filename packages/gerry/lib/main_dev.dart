import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor configuration
  FlavorConfig(
    flavor: Flavor.dev,
    name: 'Gerry Dev',
    apiBaseUrl: 'https://api.dev.gerry.com',
    appName: 'Gerry Dev',
    appId: 'com.tengu.gerry.dev',
  );

  runApp(
    const ProviderScope(
      child: GerryApp(),
    ),
  );
}
