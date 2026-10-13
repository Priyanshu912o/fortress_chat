import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../components/chat_exceptions.dart';

import 'network_config.dart';

@lazySingleton
class ApiClient {
  final Dio dio;
  final FirebaseAuth firebaseAuth;

  static String get defaultBaseUrl => NetworkConfig.baseUrl;

  ApiClient(this.dio, this.firebaseAuth) {
    dio.options = BaseOptions(
      baseUrl: defaultBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final user = firebaseAuth.currentUser;
          if (user != null) {
            try {
              final token = await user.getIdToken();
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
            } catch (_) {
              // Token retrieval failed, proceed anyway
            }
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final user = firebaseAuth.currentUser;
            if (user != null) {
              try {
                // Force refresh token
                final refreshedToken = await user.getIdToken(true);
                if (refreshedToken != null) {
                  final opts = Options(
                    method: error.requestOptions.method,
                    headers: {
                      ...error.requestOptions.headers,
                      'Authorization': 'Bearer $refreshedToken',
                    },
                  );
                  final response = await dio.request(
                    error.requestOptions.path,
                    options: opts,
                    data: error.requestOptions.data,
                    queryParameters: error.requestOptions.queryParameters,
                  );
                  return handler.resolve(response);
                }
              } catch (_) {
                // Retry failed
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.post<T>(
        path,
        data: data ?? const <String, dynamic>{},
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.patch<T>(
        path,
        data: data ?? const <String, dynamic>{},
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }


  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.delete<T>(
        path,
        data: data ?? const <String, dynamic>{},
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ChatExceptions _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const NetworkException('Connection to Fortress Chat server timed out.');
    }

    final statusCode = e.response?.statusCode;
    final message = (e.response?.data is Map && e.response?.data['message'] != null)
        ? e.response?.data['message'].toString()
        : e.message ?? 'Unknown server error';

    if (statusCode == 401) {
      return UnauthorizedException(message ?? 'Unauthorized');
    } else if (statusCode == 403) {
      return ForbiddenException(message ?? 'Forbidden');
    } else if (statusCode == 404) {
      return NotFoundException(message ?? 'Not found');
    } else if (statusCode == 400) {
      return ValidationException(message ?? 'Invalid request');
    }

    return ServerException(message ?? 'Server error occurred');
  }
}
