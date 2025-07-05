import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'network_exception.dart';
import 'models/api_response.dart';

class DioClient {
  final Dio _dio;
  final Logger _logger;
  final SharedPreferences _prefs;

  DioClient({
    required String baseUrl,
    required Logger logger,
    required SharedPreferences prefs,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  })  : _logger = logger,
        _prefs = prefs,
        _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: connectTimeout ?? const Duration(seconds: 30),
            receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
          ),
        ) {
    _dio.interceptors.addAll([
      LoggingInterceptor(_logger),
      AuthInterceptor(_prefs, _dio),
    ]);
  }

  Dio get dio => _dio;

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      if (parser != null) {
        return ApiResponse(
          success: true,
          message: 'Success',
          data: parser(response.data),
        );
      }
      return ApiResponse(
        success: true,
        message: 'Success',
        data: response.data as T,
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (parser != null) {
        return ApiResponse.success(parser(response.data));
      }
      return ApiResponse.success(response.data as T);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (parser != null) {
        return ApiResponse.success(parser(response.data));
      }
      return ApiResponse.success(response.data as T);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (parser != null) {
        return ApiResponse.success(parser(response.data));
      }
      return ApiResponse.success(response.data as T);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
