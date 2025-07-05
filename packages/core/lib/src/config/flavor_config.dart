enum Flavor {
  dev,
  staging,
  prod,
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final String apiBaseUrl;
  final String appName;
  final String appId;

  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required String apiBaseUrl,
    required String appName,
    required String appId,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor: flavor,
      name: name,
      apiBaseUrl: apiBaseUrl,
      appName: appName,
      appId: appId,
    );
    return _instance!;
  }

  FlavorConfig._internal({
    required this.flavor,
    required this.name,
    required this.apiBaseUrl,
    required this.appName,
    required this.appId,
  });

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isDevelopment() => _instance?.flavor == Flavor.dev;
  static bool isStaging() => _instance?.flavor == Flavor.staging;
  static bool isProduction() => _instance?.flavor == Flavor.prod;
}
