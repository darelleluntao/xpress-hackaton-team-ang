import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    StateNotifierProvider<SharedPreferencesNotifier, SharedPreferences?>((ref) {
  return SharedPreferencesNotifier();
});

class SharedPreferencesNotifier extends StateNotifier<SharedPreferences?> {
  SharedPreferencesNotifier() : super(null);

  Future<void> initialize() async {
    state = await SharedPreferences.getInstance();
  }
}
