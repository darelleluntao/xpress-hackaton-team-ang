import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor configuration
  FlavorConfig(
    flavor: Flavor.staging,
    name: 'Gerry Staging',
    apiBaseUrl: 'https://api.staging.gerry.com',
    appName: 'Gerry Staging',
    appId: 'com.tengu.gerry.staging',
  );

  runApp(
    const ProviderScope(
      child: GerryApp(),
    ),
  );
}
