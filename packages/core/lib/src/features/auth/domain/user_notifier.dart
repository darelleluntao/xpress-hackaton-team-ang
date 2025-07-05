import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/core.dart';

part 'user_notifier.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.success(User user) = _Success;
  const factory UserState.error(String message) = _Error;
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState.initial());

  Future<bool> login(String email, String password) async {
    try {
      state = const UserState.loading();
      // TODO: Implement actual login logic
      await Future.delayed(
          const Duration(seconds: 2)); // Simulate network delay
      state = UserState.success(
        User(
          id: 1,
          name: 'Test User',
          email: email,
        ),
      );
      return true;
    } catch (e) {
      state = UserState.error(e.toString());
      return false;
    }
  }

  void logout() {
    state = const UserState.initial();
  }
}

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
