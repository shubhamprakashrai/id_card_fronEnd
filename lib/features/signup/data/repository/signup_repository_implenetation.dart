import 'package:id_card_front_end/core/constants/api_constants.dart';
import 'package:id_card_front_end/core/local/hive_local_storage.dart';
import 'package:id_card_front_end/core/network/api_client.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';
import 'package:id_card_front_end/features/signup/domain/respository/signup_base_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignupBaseRepository)
class SignupRepositoryImplenetation extends SignupBaseRepository{
  
  final ApiClient apiClient;
  const SignupRepositoryImplenetation(this.apiClient);

  @override
  Future<SignupResponseModel> signUpUser(SignupRequestModel model) async {
    try {
      final response= await apiClient.post(data: model.toJson(), ApiConstants.registerUrl);
      final signupResponse = SignupResponseModel.fromJson(response.data);
      await HiveStorage.instance.savedToken(signupResponse.token);
      await HiveStorage.instance.saveUser(signupResponse.user);
    return signupResponse;
      
    } catch (e) {
      // print("Signup API error: $e");
      throw Exception("Signup failed: $e");
    }
  }
  
}