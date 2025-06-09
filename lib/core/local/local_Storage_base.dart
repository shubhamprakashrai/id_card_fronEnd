import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';

abstract class LocalStorage {
  Future<void> savedToken(String token);
  Future<String?> getToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearStorage();
 
}