import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/core/local/hive_local_storage.dart';
import 'package:id_card_front_end/core/local/local_Storage_base.dart';
import 'package:injectable/injectable.dart';

enum AuthStatus{unKnown, authenticated, unAuthenticated}

@injectable
class AuthCubit extends Cubit<AuthStatus>{
 final LocalStorage hiveStorage;
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