import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/features/signup/domain/usecases/user_signup_usecase.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_event.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_state.dart';
import 'package:logger/web.dart';

class SignupBloc extends Bloc<SignupEvent,SignupState> {
  final UserSignupUsecase userSignupUsecase;
  final Logger logger = Logger();
  SignupBloc({required this.userSignupUsecase}):super(SignupIntialState()){
    on<SignupUserEvent>(_signUpUser);
  }

 void _signUpUser(SignupUserEvent event, Emitter<SignupState> emit) async {
    try {
      logger.d("response in sign up bloc1");
      emit(SignupLoadingState());
      final response = await userSignupUsecase(event.requestModel);
      logger.d("response in sign up bloc2 $response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignupSucessState(responseData: response.data));
      } else {
        emit(SignupErrorState(errorMesage: "Signup failed3: ${response.statusMessage}"));
      }
    } catch (e) {
      logger.e("error in sign up bloc4 $e");
      emit(SignupErrorState(errorMesage: e.toString()));
    }
  }
}