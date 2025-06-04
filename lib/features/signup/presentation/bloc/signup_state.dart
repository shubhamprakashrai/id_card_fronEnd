abstract class SignupState{
  
}

class SignupIntialState extends SignupState{

}

class SignupLoadingState extends SignupState{

}

class SignupSucessState  extends SignupState{
    final dynamic responseData;
  SignupSucessState({required this.responseData});
}

class SignupErrorState  extends SignupState{
  String errorMesage;
  SignupErrorState({required this.errorMesage});
}