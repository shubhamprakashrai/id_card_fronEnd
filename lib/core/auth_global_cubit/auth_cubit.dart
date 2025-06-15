import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/core/local/hive_local_storage.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart' show UserModel;
import 'package:injectable/injectable.dart';

enum AuthStatus{
  unKnown,
  authenticated,
  unAuthenticated;

  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isUnAuthenticated => this == AuthStatus.unAuthenticated;

  AuthStatus copyWith({AuthStatus? status}) {
    return status ?? this;
  }

}

@injectable
class AuthCubit extends Cubit<AuthStatus>{

  AuthCubit() : super(AuthStatus.unKnown);

  Future<void> checkAuthStatus() async {
    try {
      print('Checking auth status...');
      final token = await HiveStorage.instance.getToken();
      print('Token from storage: $token');

      if (token != null) {
        emit(state.copyWith(status: AuthStatus.authenticated));
      } else {
        emit(state.copyWith(status: AuthStatus.unAuthenticated));
      }
    } catch (e) {
      print('Error checking auth status: $e');
      emit(state.copyWith(status: AuthStatus.unAuthenticated));
    }
  }

  Future<void> logOut()async{
   await HiveStorage.instance.clearAll();
   emit(AuthStatus.unAuthenticated);
  }


 // Retrieve both these data from the method that is calling this method
  // so that you can save the user and token
  // and if status is logout, then clear the local storage
   Future<void> updateAuthStatus(AuthStatus status, UserModel user, String token) async {

   // Write code to get the required data to check login, so if status is login, then save the data to local storage
    // and if status is logout, then clear the local storage
    // method is save user and save token
    if (status == AuthStatus.authenticated) {
     // Retrieve both these data from the method that is calling this method
     await HiveStorage.instance.saveUser(user);
     await HiveStorage.instance.setAuthToken(token);
    }
    emit(status);
  }
 
}