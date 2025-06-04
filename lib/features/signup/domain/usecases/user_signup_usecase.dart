import 'package:dio/dio.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';
import 'package:id_card_front_end/features/signup/domain/respository/signup_base_repository.dart';

class UserSignupUsecase {
  final SignupBaseRepository repository;

  UserSignupUsecase(this.repository);

  Future<Response> call(SignupRequestModel params) async {
    return await repository.signUpUser(params);
  }
}
