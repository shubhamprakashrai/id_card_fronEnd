
import 'package:id_card_front_end/core/usecase/usecases.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';
import 'package:id_card_front_end/features/signup/domain/respository/signup_base_repository.dart';

class UserSignupUsecase implements BaseUseCase<SignupResponseModel, SignupRequestModel>{
  final SignupBaseRepository repository;

  const UserSignupUsecase(this.repository);

  @override
  Future<SignupResponseModel> call(SignupRequestModel params) async {
    return await repository.signUpUser(params);
  }
}
