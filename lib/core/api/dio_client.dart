import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:path_provider/path_provider.dart';

import '../config/app_config.dart';
import 'api_exceptions.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;
  late final DioCacheInterceptor _cacheInterceptor;

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

    // Initialize with memory cache first
    _cacheInterceptor = DioCacheInterceptor(
      options: CacheOptions(
        store: MemCacheStore(),
        policy: CachePolicy.request,
        maxStale: AppConfig.cacheDuration,
        priority: CachePriority.normal,
        hitCacheOnErrorExcept: [401, 403, 404],
      ),
    );

    dio.interceptors.add(_cacheInterceptor);

    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
        handler.reject(_convertToApiException(e));
      },
    ));
  }

  /// Initialize disk-backed cache
  Future<void> initDiskCache() async {
    try {
      final dir = await getTemporaryDirectory();
      
      // For dio_cache_interceptor 4.x, use the correct store
      final diskStore = FileCacheStore(dir.path);

      final diskOptions = CacheOptions(
        store: diskStore,
        policy: CachePolicy.request,
        maxStale: AppConfig.cacheDuration,
        priority: CachePriority.high,
        hitCacheOnErrorExcept: [401, 403, 404],
      );

      // Remove old interceptor and add new one
      dio.interceptors.remove(_cacheInterceptor);
      _cacheInterceptor = DioCacheInterceptor(options: diskOptions);
      dio.interceptors.add(_cacheInterceptor);
    } catch (e) {
      // Fallback to memory store - keep using the existing one
      print('Failed to initialize disk cache: $e');
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
    Duration? cacheDuration,
    bool forceRefresh = false,
  }) async {
    try {
      final options = (forceRefresh ? CacheOptions(
        policy: CachePolicy.refresh,
        maxStale: cacheDuration ?? AppConfig.cacheDuration,
      ) : CacheOptions(
        policy: CachePolicy.request,
        maxStale: cacheDuration ?? AppConfig.cacheDuration,
      )).toOptions();

      return await dio.get(path, queryParameters: params, options: options);
    } on DioException catch (e) {
      throw _convertToApiException(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
  }) async {
    try {
      return await dio.post(
        path,
        data: data,
        queryParameters: params,
      );
    } on DioException catch (e) {
      throw _convertToApiException(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
  }) async {
    try {
      return await dio.put(
        path,
        data: data,
        queryParameters: params,
      );
    } on DioException catch (e) {
      throw _convertToApiException(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    try {
      return await dio.delete(
        path,
        queryParameters: params,
      );
    } on DioException catch (e) {
      throw _convertToApiException(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  // Helper method to convert DioException to ApiException
  ApiException _convertToApiException(DioException error) {
    return ApiException.fromDioError(error);
  }

  Dio get client => dio;
}