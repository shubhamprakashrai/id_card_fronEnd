import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:id_card_front_end/core/local/local_Storage_base.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';

class HiveStorage extends  LocalStorage{
  static const String _boxName='authBox';
  static const String _tokenKey='token';
  static const String _userKey='user';

  Box<String> get  _box=>Hive.box(_boxName);

   @override
  Future<void> savedToken(String token) async{
    await _box.put(_tokenKey, token);
  }

  @override
  Future<String?> getToken()async {
   return _box.get(_tokenKey);
  }

   @override
  Future<void> saveUser(UserModel user)async {
    final jsonString=jsonEncode(user);
    await _box.put(_userKey,jsonString);
  }


  @override
  Future<UserModel?> getUser() async{
   final jsonString=_box.get(_userKey);
  if(jsonString==null){
  return null;
  }
  return UserModel.fromJson(jsonDecode(jsonString));
  }


 
  @override
  Future<void> clearStorage()async {
    _box.clear();
  }

  
}