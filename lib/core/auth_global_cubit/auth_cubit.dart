import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/core/local/hive_local_storage.dart';

enum AuthStatus{unKnown, authenticated, unAuthenticated}
class AuthCubit extends Cubit<AuthStatus>{
 final HiveStorage hiveStorage;
  AuthCubit(this.hiveStorage):super(AuthStatus.unKnown);

  Future<void> checkAuthStatus()async{
  final token=await hiveStorage.getToken();
   if (token!=null && token.isNotEmpty) {
     emit(AuthStatus.authenticated);
   }
   else{
     emit(AuthStatus.unAuthenticated);
   }
  }
  Future<void> logOut()async{
   await hiveStorage.clearStorage();
   emit(AuthStatus.unAuthenticated);
  }

   Future<void> updateAuthStatus(AuthStatus status) async {
    emit(status);
  }
 
}