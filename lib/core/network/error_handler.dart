import 'package:dio/dio.dart';
import 'data_source.dart';
import 'failure.dart';

class ErrorHandler {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultError.getFailure();
    }
  }

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response?.statusCode, error.response?.data);
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.connectionError.getFailure();
      case DioExceptionType.unknown:
        if (error.message?.contains("SocketException") ?? false) {
          return DataSource.noInternetConnection.getFailure();
        }
        return DataSource.defaultError.getFailure();
      default:
        return DataSource.defaultError.getFailure();
    }
  }

  Failure _handleBadResponse(int? statusCode, dynamic response) {
    switch (statusCode) {
      case 400:
        return DataSource.badRequest.getFailure();
      case 401:
        return DataSource.unauthorised.getFailure();
      case 403:
        return DataSource.forbidden.getFailure();
      case 404:
        return DataSource.notFound.getFailure();
      case 500:
        return DataSource.internetServerError.getFailure();
      default:
        return DataSource.defaultError.getFailure();
    }
  }
}
