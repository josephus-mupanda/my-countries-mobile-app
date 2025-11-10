import 'package:dio/dio.dart';

class ApiException implements Exception {
  
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException(message: $message, statusCode: $statusCode)';

  factory ApiException.fromDioError(DioException error) {
    // DioErrorType changed names in newer dio; handle common cases:
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('Connection timed out. Please check your internet connection.');
      case DioExceptionType.badResponse:
        final resp = error.response;
        try {
          // Try to read a message if API provides one
          final msg = resp?.data is Map && resp!.data['message'] != null
              ? resp.data['message'].toString()
              : resp?.statusMessage ?? 'Bad response from server';
          return ApiException(msg, statusCode: resp?.statusCode);
        } catch (_) {
          return ApiException('Bad response from server', statusCode: resp?.statusCode);
        }
      case DioExceptionType.cancel:
        return ApiException('Request to server was cancelled.');
      case DioExceptionType.unknown:
      default:
        // network errors or other unknown errors
        final msg = error.message ?? 'Unexpected error occurred';
        return ApiException(msg);
    }
  }
}
