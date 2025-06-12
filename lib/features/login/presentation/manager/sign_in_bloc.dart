import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';
import 'package:logger/web.dart';
import '../../domain/usecase/user_sign_in_usecase.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent,SignInState> {
SignInUsecase signInUsecase;
  SignInBloc({required this.signInUsecase}):super(SignInInitialState()){
    on<UserSignInEvent>(_userSignIn);
  }
 Logger logger=Logger();
 void _userSignIn(UserSignInEvent event, Emitter<SignInState> emit)async{
  try {
    emit(SignupProcessingState());
    SignupResponseModel userSignInResponce=await signInUsecase.call(event.signInRequestModel);
    emit(SignInSucessState(signInResponseModel: userSignInResponce));
  } catch (e) {
    logger.e("Error message from _userSignIn $e");
    emit(SignInErrorState("Error message from _userSignIn"));
  }
 }
}

