import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_interceptor.dart';

class AuthInterceptor extends BaseInterceptor {
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  final Dio _dio;

  AuthInterceptor(this._prefs, this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _prefs.getString(_tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Try to refresh token
      final refreshToken = _prefs.getString(_refreshTokenKey);
      if (refreshToken != null) {
        try {
          final response = await _dio.post(
            '/auth/refresh',
            data: {'refresh_token': refreshToken},
          );

          if (response.statusCode == 200) {
            final newToken = response.data['token'];
            final newRefreshToken = response.data['refresh_token'];

            await _prefs.setString(_tokenKey, newToken);
            await _prefs.setString(_refreshTokenKey, newRefreshToken);

            // Retry the original request
            final opts = err.requestOptions;
            opts.headers['Authorization'] = 'Bearer $newToken';

            final retryResponse = await _dio.fetch(opts);
            return handler.resolve(retryResponse);
          }
        } catch (e) {
          // If refresh fails, clear tokens and continue with error
          await _prefs.remove(_tokenKey);
          await _prefs.remove(_refreshTokenKey);
        }
      } else {
        // No refresh token, clear auth token
        await _prefs.remove(_tokenKey);
      }
    }
    super.onError(err, handler);
  }
}
