import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';

abstract class SignInState {
  const SignInState();
}

class SignInInitialState extends SignInState {
  const SignInInitialState();
}

class SignInSucessState extends SignInState {
  final SignupResponseModel signInResponseModel;
  const SignInSucessState({required this.signInResponseModel});
}

class SignInErrorState extends SignInState {
  final String errrorMessage;
  const SignInErrorState(this.errrorMessage);
}

class SignupProcessingState extends SignInState {
  const SignupProcessingState();
}
