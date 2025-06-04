import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';

class SignupEvent{

}

class SignupUserEvent extends SignupEvent{
 final SignupRequestModel requestModel;
  SignupUserEvent(this.requestModel);
}