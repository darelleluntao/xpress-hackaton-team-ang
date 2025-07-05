import 'package:dio/dio.dart';
import 'dio_client.dart';
import 'models/api_response.dart';
import 'network_exception.dart';

abstract class BaseRepository {
  final DioClient _dioClient;

  BaseRepository(this._dioClient);

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    T Function(dynamic data)? parser,
  }) async {
    try {
      return await _dioClient.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        parser: parser,
      );
    } on NetworkException catch (e) {
      return ApiResponse.error(e.message);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
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
      return await _dioClient.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        parser: parser,
      );
    } on NetworkException catch (e) {
      return ApiResponse.error(e.message);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
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
      return await _dioClient.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        parser: parser,
      );
    } on NetworkException catch (e) {
      return ApiResponse.error(e.message);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
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
      return await _dioClient.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        parser: parser,
      );
    } on NetworkException catch (e) {
      return ApiResponse.error(e.message);
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
    }
  }
}
