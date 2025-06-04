

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/features/signup/domain/usecases/user_signup_usecase.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_event.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent,SignupState> {
  final UserSignupUsecase userSignupUsecase;
  SignupBloc({required this.userSignupUsecase}):super(SignupIntialState()){
    on<SignupUserEvent>(_signUpUser);
  }

 void _signUpUser(SignupUserEvent event, Emitter<SignupState> emit) async {
    try {
      log("response in sign up bloc");
      emit(SignupLoadingState());
      final response = await userSignupUsecase(event.requestModel);
      log("response in sign up bloc $response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignupSucessState(responseData: response.data));
      } else {
        emit(SignupErrorState(errorMesage: "Signup failed: ${response.statusMessage}"));
      }
    } catch (e) {
      log("error in sign up bloc $e");
      emit(SignupErrorState(errorMesage: e.toString()));
    }
  }
}