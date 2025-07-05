import 'package:dio/dio.dart';

abstract class BaseInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add common request headers
    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    // Add timestamp for cache busting
    options.queryParameters['_t'] =
        DateTime.now().millisecondsSinceEpoch.toString();

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Add common response handling
    if (response.statusCode == 204) {
      response.data = null;
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Add common error handling
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Connection timeout. Please check your internet connection.',
          type: err.type,
        ),
      );
      return;
    }

    super.onError(err, handler);
  }
}
