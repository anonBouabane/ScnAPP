import 'package:dio/dio.dart' as dio_response;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../util/app_constants.dart';
import '../controllers/storage_controller.dart';
import '../routes/app_pages.dart';
import 'api_endpoint.dart';

class ApiClient {
  final StorageController storageController = Get.put(StorageController());

  final dio_response.Dio _dio = dio_response.Dio(
    dio_response.BaseOptions(
      baseUrl: AppConstants.BASE_URL,
      connectTimeout: ApiEndpoint.connectTimeout,
      receiveTimeout: ApiEndpoint.receiveTimeout,
      responseType: dio_response.ResponseType.json,
      contentType: dio_response.Headers.jsonContentType,
    ),
  );

  ApiClient() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    _dio.interceptors.add(dio_response.InterceptorsWrapper(
      onRequest: (options, handler) async {
        String token = storageController.accessToken;
        Logger().w(
          'token: $token\n'
          '${options.uri}',
        );
        if (token.isNotEmpty) {
          Logger().w(
            'token: $token\n'
            '${options.uri}',
          );
          // bool hasExpired = JwtDecoder.isExpired(token);
          // if (hasExpired) {
          //   Get.offAllNamed(Routes.LOGIN);
          // } else {
          options.headers['Authorization'] = 'Bearer $token';
          // }
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (kDebugMode) {
          // Logger().e(error);
          Logger().e(
              'onError: ${error.response?.statusCode} ${error.response?.statusMessage}');
        }
        if (error.response?.statusCode == 401) {
          storageController.clearStorage();
          Get.offAllNamed(Routes.LOGIN);
          //   final newAccessToken = await refreshToken();
          //   if (newAccessToken != null) {
          //     _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
          //     return handler.resolve(await _dio.fetch(error.requestOptions));
          //   }
        }
        return handler.next(error);
      },
    ));
  }

  Future<dio_response.Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    dio_response.Options? options,
    dio_response.CancelToken? cancelToken,
    dio_response.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dio_response.Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio_response.Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio_response.Options? options,
    dio_response.CancelToken? cancelToken,
    dio_response.ProgressCallback? onSendProgress,
    dio_response.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dio_response.Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio_response.Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio_response.Options? options,
    dio_response.CancelToken? cancelToken,
    dio_response.ProgressCallback? onSendProgress,
    dio_response.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dio_response.Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio_response.Response> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio_response.Options? options,
    dio_response.CancelToken? cancelToken,
    dio_response.ProgressCallback? onSendProgress,
    dio_response.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dio_response.Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio_response.Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio_response.Options? options,
    dio_response.CancelToken? cancelToken,
    dio_response.ProgressCallback? onSendProgress,
    dio_response.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dio_response.Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
