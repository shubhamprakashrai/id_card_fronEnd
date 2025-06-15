import 'package:dio/dio.dart';
import 'package:id_card_front_end/core/constants/api_constants.dart';
import 'package:id_card_front_end/core/network/dio_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';
import 'error_handler.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const int apiTimeOut = 60000;

@lazySingleton
class ApiClient {
  final Logger logger = Logger();
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': applicationJson,
          'Accept': applicationJson,
        },
        connectTimeout: Duration(milliseconds: apiTimeOut),
        receiveTimeout: Duration(milliseconds: apiTimeOut),
        sendTimeout: Duration(milliseconds: apiTimeOut),
        baseUrl: ApiConstants.baseUrl,
      ),
    )..interceptors.add(BaseInterceptor());
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      return await _dio.get(path, queryParameters: query);
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (error) {
      logger.e("error in network layer $error");
      throw ErrorHandler.handle(error).failure;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
