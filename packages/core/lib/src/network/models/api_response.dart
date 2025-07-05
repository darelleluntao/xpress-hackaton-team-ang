import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    required String message,
    required T data,
  }) = _ApiResponse;

  factory ApiResponse.success(T data) => ApiResponse(
        success: true,
        message: 'Success',
        data: data,
      );

  factory ApiResponse.error(String message) => ApiResponse(
        success: false,
        message: message,
        data: null as T,
      );

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as T,
    );
  }
}
