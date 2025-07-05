import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton(sharedPreferences);

  // Logger
  sl.registerLazySingleton<Logger>(
    () => Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    ),
  );

  // DioClient
  sl.registerLazySingleton<DioClient>(
    () => DioClient(
      baseUrl: 'https://api.example.com', // Replace with your API base URL
      logger: sl<Logger>(),
      prefs: sl<SharedPreferences>(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepository(sl<DioClient>()),
  );

  // Add your repositories, use cases, and other dependencies here
}
