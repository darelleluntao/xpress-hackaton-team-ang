import 'package:core/core.dart';

class UserRepository extends BaseRepository<User> {
  final DioClient dioClient;

  UserRepository(this.dioClient);

  @override
  Future<User> get(String id) async {
    final response = await dioClient.get('/users/$id');
    return User.fromJson(response.data);
  }

  @override
  Future<List<User>> getAll() async {
    final response = await dioClient.get('/users');
    return (response.data as List).map((json) => User.fromJson(json)).toList();
  }

  @override
  Future<User> create(User data) async {
    final response = await dioClient.post('/users', data: data.toJson());
    return User.fromJson(response.data);
  }

  @override
  Future<User> update(String id, User data) async {
    final response = await dioClient.put('/users/$id', data: data.toJson());
    return User.fromJson(response.data);
  }

  @override
  Future<void> delete(String id) async {
    await dioClient.delete('/users/$id');
  }

  Future<ApiResponse<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    final response = await dioClient.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return ApiResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ApiResponse<User>> getProfile() async {
    final response = await dioClient.get('/users/profile');
    return ApiResponse.fromJson(response.data);
  }

  Future<ApiResponse<User>> updateProfile({
    required String name,
    String? avatar,
  }) async {
    final response = await dioClient.put(
      '/users/profile',
      data: {
        'name': name,
        if (avatar != null) 'avatar': avatar,
      },
    );
    return ApiResponse.fromJson(response.data);
  }

  Future<ApiResponse<void>> logout() async {
    final response = await dioClient.post('/auth/logout');
    return ApiResponse.fromJson(response.data);
  }
}
