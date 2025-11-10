import 'dart:io';
import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final DioExceptionType? errorType;

  ApiException(this.message, {this.statusCode, this.errorType});

  @override
  String toString() => 'ApiException(message: $message, statusCode: $statusCode, errorType: $errorType)';

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          'Connection timed out. Please check your internet connection.',
          errorType: error.type,
        );
      case DioExceptionType.badResponse:
        final resp = error.response;
        try {
          // Try to read a message if API provides one
          final msg = resp?.data is Map && resp!.data['message'] != null
              ? resp.data['message'].toString()
              : resp?.statusMessage ?? 'Bad response from server';
          return ApiException(
            msg,
            statusCode: resp?.statusCode,
            errorType: error.type,
          );
        } catch (_) {
          return ApiException(
            'Bad response from server',
            statusCode: resp?.statusCode,
            errorType: error.type,
          );
        }
      case DioExceptionType.cancel:
        return ApiException(
          'Request to server was cancelled.',
          errorType: error.type,
        );
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return ApiException(
            'No internet connection. Please check your network settings.',
            errorType: error.type,
          );
        }
        return ApiException(
          error.message ?? 'Unexpected error occurred',
          errorType: error.type,
        );
      case DioExceptionType.badCertificate:
        return ApiException(
          'SSL certificate error. Please try again later.',
          errorType: error.type,
        );
      case DioExceptionType.connectionError:
        return ApiException(
          'Connection error. Please check your internet connection.',
          errorType: error.type,
        );
      default:
        return ApiException(
          error.message ?? 'Unexpected error occurred',
          errorType: error.type,
        );
    }
  }
}