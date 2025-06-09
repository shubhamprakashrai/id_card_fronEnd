import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';

abstract class SignupState{
  const SignupState();
}

class SignupIntialState extends SignupState{
   const SignupIntialState();
}

class SignupLoadingState extends SignupState{
  const SignupLoadingState();
}

class SignupSucessState  extends SignupState{
    final SignupResponseModel responseData;
  const SignupSucessState({required this.responseData});
}

class SignupErrorState  extends SignupState{
  final String errorMesage;
  const SignupErrorState({required this.errorMesage});
}