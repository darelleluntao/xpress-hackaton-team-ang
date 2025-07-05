import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor configuration
  FlavorConfig(
    flavor: Flavor.staging,
    name: 'Ned Staging',
    apiBaseUrl: 'https://api.staging.ned.com',
    appName: 'Ned Staging',
    appId: 'com.tengu.ned.staging',
  );

  runApp(
    const ProviderScope(
      child: NedApp(),
    ),
  );
}
