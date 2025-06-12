
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';

abstract class SignInState {

}

class SignInInitialState extends SignInState {

}

class SignInSucessState extends SignInState{
  SignupResponseModel signInResponseModel;
  SignInSucessState({required this.signInResponseModel});
}

class SignInErrorState extends SignInState {
  String errrorMessage;
  SignInErrorState(this.errrorMessage);
  
}

class SignupProcessingState extends SignInState {
  
}

