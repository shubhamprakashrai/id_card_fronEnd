import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = dotenv.env['BASE_URL'] ??'http://10.0.2.2:5000/api/';
  static String get registerUrl => 'auth/register';
  static String get loginUrl => 'auth/login';
  
}
