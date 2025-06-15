import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';
import 'package:id_card_front_end/features/signup/domain/usecases/user_signup_usecase.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_event.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_state.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';

@injectable
class SignupBloc extends Bloc<SignupEvent,SignupState> {
  final UserSignupUsecase userSignupUsecase;
  final Logger logger = Logger();
  SignupBloc({required this.userSignupUsecase}):super(SignupIntialState()){
    on<SignupUserEvent>(_signUpUser);
  }
 void _signUpUser(SignupUserEvent event, Emitter<SignupState> emit) async {
    try {
      emit(SignupLoadingState());
      SignupResponseModel response = await userSignupUsecase(event.requestModel);
       logger.d("Signup Success Token: ${response.token}");
        emit(SignupSucessState(responseData: response));
    } catch (e) {
      logger.e("error in sign up bloc4 $e");
      emit(SignupErrorState(errorMesage: e.toString()));
    }
  }
}