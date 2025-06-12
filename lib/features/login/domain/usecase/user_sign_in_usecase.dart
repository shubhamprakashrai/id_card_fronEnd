import 'package:id_card_front_end/core/usecase/usecases.dart';
import '../../../signup/data/models/signup_response_model.dart';
import '../../data/models/sign_in_requestmodel.dart';
import '../repository/sign_in_base_repository.dart';

class SignInUsecase implements BaseUseCase<SignupResponseModel,SignInRequestModel>{
  SignInBaseRepositoty signInBaseRepositoty;
  SignInUsecase(this.signInBaseRepositoty);
  @override
  Future<SignupResponseModel> call(SignInRequestModel signUpRequestModel) {
   return signInBaseRepositoty.userSign(signUpRequestModel);
  }
}