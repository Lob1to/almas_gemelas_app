import 'package:dio/dio.dart';
import '../../features/shared/infrastructure/errors/app_errors.dart';

class HttpAdapter {
  final String baseUrl;
  late final Dio _dio;

  HttpAdapter({required this.baseUrl}) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      _handleRequest(() => _dio.get(
            path,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          ));

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      _handleRequest(() => _dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          ));

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      _handleRequest(() => _dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          ));

  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      _handleRequest(() => _dio.delete(
            path,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          ));

  Future<Response<T>> _handleRequest<T>(
      Future<Response<T>> Function() request) async {
    return _handleErrors(() => request());
  }

  Future<T> _handleErrors<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on DioException catch (e) {
      throw _mapDioExceptionToAppError(e);
    }
  }

  AppError _mapDioExceptionToAppError(DioException e) {
    final message =
        e.response?.data['message'] ?? 'An unexpected error occurred';
    final code = e.response?.data['code'] ?? 'unknown';
    return AppError(message, code);
  }
}
