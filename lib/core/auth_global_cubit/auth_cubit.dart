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

}

@injectable
class AuthCubit extends Cubit<AuthStatus>{

  AuthCubit():super(AuthStatus.unKnown);

  Future<bool> checkAuthStatus()async{

    // Handle errors if needed
    // and emit the appropriate state
    // For example, if an error occurs, you can emit AuthStatus.unAuthenticated
    try {
      print("Checking auth status...21");
      final token= HiveStorage.instance.authToken;
      print("Checking auth status...212 $token");
      if (token !=null && token.isNotEmpty) {
        print("User is authenticated with token: $token");
        emit(AuthStatus.authenticated);
        return true;
      }
      else{
        print("User is not authenticated, no token found.");
        emit(AuthStatus.unAuthenticated);
      }
    } catch (e) {
      print("Error checking auth status: $e");
      emit(AuthStatus.unAuthenticated);
    }

    return false;



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