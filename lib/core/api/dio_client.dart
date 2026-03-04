import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../config/app_config.dart';
import 'api_exceptions.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;
  final CacheStore _cacheStore = MemCacheStore(maxSize: 10485760); // 10MB cache

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
    ));

    // Cache interceptor
    dio.interceptors.add(DioCacheInterceptor(
      options: CacheOptions(
        store: _cacheStore,
        policy: CachePolicy.request,
        maxStale: AppConfig.cacheDuration,
        priority: CachePriority.normal,
      ),
    ));

    // Error interceptor
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
        final apiException = ApiException.fromDioError(e);
        handler.reject(
          DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            type: e.type,
            error: apiException,
            message: apiException.message,
          ),
        );
      },
    ));
  }

  // Initialize cache 
  Future<void> initDiskCache() async {

  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
    Duration? cacheDuration,
    bool forceRefresh = false,
    Options? options,
  }) async {
    try {
      final cacheOptions = CacheOptions(
        store: _cacheStore,
        policy: forceRefresh ? CachePolicy.refresh : CachePolicy.request,
        maxStale: cacheDuration ?? AppConfig.cacheDuration,
      ).toOptions();

      final mergedOptions = options?.copyWith(
        extra: {...?options.extra, ...?cacheOptions.extra},
      ) ?? cacheOptions;

      return await dio.get(
        path, 
        queryParameters: params, 
        options: mergedOptions,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      return await dio.post(
        path,
        data: data,
        queryParameters: params,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      return await dio.put(
        path,
        data: data,
        queryParameters: params,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      return await dio.delete(
        path,
        queryParameters: params,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Dio get client => dio;

  /// Clear cache
  Future<void> clearCache() async {
    try {
      await _cacheStore.clean();
    } catch (e) {
      //print('Failed to clear cache: $e');
    }
  }
}