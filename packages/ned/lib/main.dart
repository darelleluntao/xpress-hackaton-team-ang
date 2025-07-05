import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

class NedApp extends ConsumerWidget {
  const NedApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = FlavorConfig.instance;

    return MaterialApp.router(
      title: config.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
