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
    final dynamic responseData;
  const SignupSucessState({required this.responseData});
}

class SignupErrorState  extends SignupState{
  final String errorMesage;
  const SignupErrorState({required this.errorMesage});
}