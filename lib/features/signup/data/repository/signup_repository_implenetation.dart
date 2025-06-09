import 'package:id_card_front_end/core/constants/api_constants.dart';
import 'package:id_card_front_end/core/local/hive_local_storage.dart';
import 'package:id_card_front_end/core/local/local_Storage_base.dart';
import 'package:id_card_front_end/core/network/api_client.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';
import 'package:id_card_front_end/features/signup/domain/respository/signup_base_repository.dart';

class SignupRepositoryImplenetation extends SignupBaseRepository{
  
  final ApiClient apiClient;
  final LocalStorage localStorage;
  SignupRepositoryImplenetation(this.apiClient, this.localStorage);

  @override
  Future<SignupResponseModel> signUpUser(SignupRequestModel model) async {
    try {
      final response= await apiClient.post(data: model.toJson(), ApiConstants.registerUrl);
      final signupResponse = SignupResponseModel.fromJson(response.data);
      await localStorage.savedToken(signupResponse.token);
      await localStorage.saveUser(signupResponse.user);
    return signupResponse;
      
    } catch (e) {
      print("Signup API error: $e");
      throw Exception("Signup failed: $e");
    }
  }
  
}