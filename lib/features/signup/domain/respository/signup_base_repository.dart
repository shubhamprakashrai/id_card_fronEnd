import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';

abstract class SignupBaseRepository {
  const SignupBaseRepository();
  Future<SignupResponseModel> signUpUser(SignupRequestModel model);
}