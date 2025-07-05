import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  NetworkException({
    required this.message,
    this.statusCode,
    this.data,
  });

  factory NetworkException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timeout',
          statusCode: error.response?.statusCode,
          data: error.response?.data,
        );
      case DioExceptionType.badResponse:
        return NetworkException(
          message:
              _handleError(error.response?.statusCode, error.response?.data),
          statusCode: error.response?.statusCode,
          data: error.response?.data,
        );
      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request cancelled',
          statusCode: error.response?.statusCode,
          data: error.response?.data,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection',
          statusCode: error.response?.statusCode,
          data: error.response?.data,
        );
      case DioExceptionType.unknown:
        return NetworkException(
          message: 'Something went wrong',
          statusCode: error.response?.statusCode,
          data: error.response?.data,
        );
      default:
        return NetworkException(
          message: 'Unknown error occurred',
          statusCode: error.response?.statusCode,
          data: error.response?.data,
        );
    }
  }

  static String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      case 504:
        return 'Gateway timeout';
      default:
        return 'Something went wrong';
    }
  }
}
