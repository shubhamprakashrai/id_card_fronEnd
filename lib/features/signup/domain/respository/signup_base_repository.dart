import 'package:dio/dio.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';

abstract class SignupBaseRepository {
  Future<Response> signUpUser(SignupRequestModel model);
}