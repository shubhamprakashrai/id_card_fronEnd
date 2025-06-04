class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unauthorised = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -8;
  static const int connectionError = -9;
}


class ResponseMessage {
  static const String success = "Success";
  static const String noContent = "No content available";
  static const String badRequest = "Bad request";
  static const String unauthorised = "Unauthorized";
  static const String forbidden = "Forbidden";
  static const String notFound = "Not found";
  static const String internalServerError = "Internal server error";
  static const String connectTimeout = "Connection timeout";
  static const String cancel = "Request cancelled";
  static const String receiveTimeout = "Receive timeout";
  static const String sendTimeout = "Send timeout";
  static const String cacheError = "Cache error";
  static const String noInternetConnection = "No internet connection";
  static const String defaultError = "Something went wrong";
  static const String connectionError = "Connection error";
}
