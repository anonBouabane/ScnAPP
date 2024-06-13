import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiException implements Exception {
  late String message;

  ApiException.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        message = "Unexpected error occurred";
        break;
      case DioExceptionType.connectionError:
        message = "Connection Error";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    Logger().w('$statusCode\n$error');
    switch (statusCode) {
      case 400:
        return error['msg'] ?? 'Bad Request';
      case 401:
        return error['msg'] ?? 'Unauthorized';
      case 403:
        return error['msg'] ?? 'Forbidden';
      case 404:
        return error['msg'] ?? 'Not found';
      case 422:
        var message = '';
        for (var i = 0; i < error['errors'].length; i++) {
          message += error['errors'][i]['msg'];
          if (i != error['errors'].length) {
            message += '\n';
          }
        }
        return message;
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
