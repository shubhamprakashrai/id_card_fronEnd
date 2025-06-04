import 'dart:developer';
import 'package:dio/dio.dart';

class AppInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST → ${options.method} ${options.baseUrl}${options.path}',
        name: 'API',
        level: 800,
        error: {
          'headers': options.headers,
          'query': options.queryParameters,
          'body': options.data,
        });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE ← ${response.statusCode} ${response.requestOptions.path}',
        name: 'API',
        level: 800,
        error: response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR ⛔ [${err.response?.statusCode}] ${err.requestOptions.path}',
        name: 'API',
        level: 1000,
        error: {
          'message': err.message,
          'type': err.type,
          'data': err.response?.data,
        },
        stackTrace: err.stackTrace);
    super.onError(err, handler);
  }
}
