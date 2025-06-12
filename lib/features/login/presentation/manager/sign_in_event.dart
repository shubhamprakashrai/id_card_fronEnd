import 'package:id_card_front_end/features/login/data/models/sign_in_requestmodel.dart';

abstract class SignInEvent {
  
} 

class UserSignInEvent extends SignInEvent {
  SignInRequestModel signInRequestModel;
  UserSignInEvent({required this.signInRequestModel});
}
  
