// lib/core/network/dio_client.dart
import 'dart:io';

import 'package:countries_app/core/api/api_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:path_provider/path_provider.dart';

import '../config/app_config.dart';

/// A singleton Dio client configured for the app.
/// - Uses AppConfig.apiBaseUrl
/// - Adds a DioCacheInterceptor with a DiskCacheStore (initDiskCache must be called after app start)
/// - No auth / JWT logic included (per project requirement)
class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late final Dio dio;
  late DioCacheInterceptor _cacheInterceptor;

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Default: in-memory cache until disk store is initialized
    final defaultOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.requestFirst,
      maxStale: AppConfig.cacheDuration,
      priority: CachePriority.normal,
      hitCacheOnErrorExcept: [401, 403],
    );

    _cacheInterceptor = DioCacheInterceptor(options: defaultOptions);
    dio.interceptors.add(_cacheInterceptor);

    // Basic error handling interceptor -> convert to ApiException
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError e, handler) {
        handler.reject(ApiException.fromDioError(e));
      },
    ));
  }

  /// Call this once (after WidgetsFlutterBinding.ensureInitialized())
  /// to set up a disk-backed cache store. It's async because of path_provider.
  Future<void> initDiskCache() async {
    try {
      final dir = await getTemporaryDirectory();
      final cacheDirPath = '${dir.path}/dio_cache';
      final diskOptions = CacheOptions(
        store: DiskCacheStore(cacheDirPath),
        policy: CachePolicy.requestFirst,
        maxStale: AppConfig.cacheDuration,
        priority: CachePriority.normal,
        hitCacheOnErrorExcept: [401, 403],
      );

      // remove old cache interceptor and add new one with disk store
      dio.interceptors.remove(_cacheInterceptor);
      _cacheInterceptor = DioCacheInterceptor(options: diskOptions);
      dio.interceptors.add(_cacheInterceptor);
    } catch (e) {
      // If disk cache init fails, we keep in-memory cache (no throw).
      // Optionally log the error in debug mode.
      // print('DioClient.initDiskCache error: $e');
    }
  }

  /// Convenience GET that expects the caller to pass buildCacheOptions when needed.
  /// Example:
  ///   dioClient.get('all', params: {'fields': '...'}, cacheDuration: Duration(days:7));
  Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
    Duration? cacheDuration,
    bool forceRefresh = false,
  }) async {
    try {
      Options? options;
      if (cacheDuration != null) {
        options = buildCacheOptions(
          cacheDuration,
          forceRefresh: forceRefresh,
        );
      }
      return await dio.get(path, queryParameters: params, options: options);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  /// Expose raw dio in case repository needs direct calls
  Dio get client => dio;
}
