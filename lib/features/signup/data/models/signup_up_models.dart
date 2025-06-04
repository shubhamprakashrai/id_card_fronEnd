
class RegisterModel{
String? message;
RegisterModel({required this.message});
factory RegisterModel.fromJson(Map<String,dynamic> map){
  return RegisterModel(
   message:map["message"]
  );
}
}