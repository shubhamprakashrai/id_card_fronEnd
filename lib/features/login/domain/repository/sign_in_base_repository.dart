
import '../../../signup/data/models/signup_response_model.dart';
import '../../data/models/sign_in_requestmodel.dart';

abstract class SignInBaseRepositoty {

  const SignInBaseRepositoty();

  Future<SignupResponseModel> userSign(SignInRequestModel signInRequestModel);
}
