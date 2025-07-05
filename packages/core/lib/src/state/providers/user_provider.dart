import 'package:core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'user_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  BaseState<User?> build() {
    return const BaseState.initial();
  }

  Future<bool> login(String email, String password) async {
    state = const BaseState.loading();
    try {
      final response = await ref.read(userRepositoryProvider).login(
            email: email,
            password: password,
          );

      if (response.success) {
        state = BaseState.success(response.data.user);
        return true;
      } else {
        state = BaseState.error(response.message);
        return false;
      }
    } catch (e) {
      state = BaseState.error(e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    state = const BaseState.loading();
    try {
      final response = await ref.read(userRepositoryProvider).logout();
      if (response.success) {
        state = const BaseState.success(null);
      } else {
        state = BaseState.error(response.message);
      }
    } catch (e) {
      state = BaseState.error(e.toString());
    }
  }

  Future<void> getProfile() async {
    state = const BaseState.loading();
    try {
      final response = await ref.read(userRepositoryProvider).getProfile();
      if (response.success) {
        state = BaseState.success(response.data);
      } else {
        state = BaseState.error(response.message);
      }
    } catch (e) {
      state = BaseState.error(e.toString());
    }
  }
}

@riverpod
UserRepository userRepository(Ref ref) {
  return sl<UserRepository>();
}
