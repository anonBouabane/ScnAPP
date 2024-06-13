import 'dart:convert';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/data/model/response/error_response.dart';
import 'package:scn_easy/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClientLottery extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;

  // static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 300;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClientLottery({
    required this.appBaseUrl,
    required this.sharedPreferences,
  }) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    if (kDebugMode) {
      Logger().w('accessToken: $token');
    }
    updateHeader(token.toString());
  }

  void updateHeader(String token) async {
    Map<String, String> _header = {
      "Content-type": 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    _mainHeaders = _header;
  }

  Future<Response> lottoGet(String uri,
      {Map<String, dynamic>? query,
      Map<String, String>? headers,
      bool isPayment = false}) async {
    try {
      // if (Foundation.kDebugMode) {
      //   Logger().i('====> API Call: $uri\nHeader: $_mainHeaders');
      // }
      Http.Response _response = await Http.get(
        isPayment
            ? Uri.parse(AppConstants.LOTTERY_PAYMENT + uri)
            : Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      if (kDebugMode) {
        Logger().i(_response.request);
      }

      // if (Foundation.kDebugMode) {
      //   Logger().i(_response.body);
      // }

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> lottoPost(String uri, dynamic body,
      {Map<String, String>? headers, isPayment = false}) async {
    try {
      if (Foundation.kDebugMode) {
        Logger().i('API Call: $uri\nHeader: $_mainHeaders');
        Logger().i('API Call: $uri\nHeader1: $headers');
        if (isPayment) {
          Logger().i('API Call payment: $uri');
        }
        Logger().i('API Call base: ${appBaseUrl + uri}');
        Logger().i('API Body: ${jsonEncode(body)}');
      }
      Http.Response _response = await Http.post(
        isPayment
            ? Uri.parse(AppConstants.LOTTERY_PAYMENT + uri)
            : Uri.parse(appBaseUrl + uri),
        // isPayment ? Uri.parse("https://laovietbank.com.la:5678/v1/api/" + uri) : Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      if (kDebugMode) {
        Logger().i(_response.request);
      }

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> lottoPut(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      // if (Foundation.kDebugMode) {
      //   print('====> API Call: $uri\nHeader: $_mainHeaders');
      //   print('====> API Body: $body');
      // }
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      if (kDebugMode) {
        Logger().i(_response.request);
      }

      // if (Foundation.kDebugMode) {
      //   Logger().w('$_mainHeaders');
      //   Logger().w('$body');
      //   Logger().w('$appBaseUrl$uri');
      //   Logger().w(_response.body);
      // }

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      // if (Foundation.kDebugMode) {
      //   print('====> API Call: $uri\nHeader: $_mainHeaders');
      // }
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      if (kDebugMode) {
        Logger().i(_response.request);
      }

      // if (Foundation.kDebugMode) {
      //   Logger().w('$_mainHeaders');
      //   Logger().w('$appBaseUrl$uri');
      //   Logger().w(_response.body);
      // }

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putMultipartData(
      String uri, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      Http.MultipartRequest _request =
          Http.MultipartRequest('PUT', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        // if (multipart.file != null) {
        Uint8List _list = await multipart.file.readAsBytes();
        _request.files.add(Http.MultipartFile(
          multipart.key,
          multipart.file.readAsBytes().asStream(),
          _list.length,
          filename: '${DateTime.now().toString()}.png',
        ));
        // }
      }
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());

      if (Foundation.kDebugMode) {
        Logger().w('$appBaseUrl$uri');
        Logger().w(_response.body);
      }

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors[0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: _response.statusText);
    }

    return _response;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
