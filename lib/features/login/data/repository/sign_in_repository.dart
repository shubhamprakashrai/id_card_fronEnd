import 'package:id_card_front_end/core/constants/api_constants.dart';
import 'package:id_card_front_end/core/local/local_Storage_base.dart';
import 'package:id_card_front_end/core/network/api_client.dart';
import 'package:logger/web.dart';

import '../../../signup/data/models/signup_response_model.dart';
import '../../domain/repository/sign_in_base_repository.dart';
import '../models/sign_in_requestmodel.dart';

class SignInRepository extends SignInBaseRepositoty{
  final ApiClient apiClient;
  final LocalStorage localStorage;
  SignInRepository(this.apiClient,this.localStorage);
  Logger logger=Logger();

  @override
  Future<SignupResponseModel> userSign(SignInRequestModel signInRequestModel) async {
   try {
      final response=(await apiClient.post(data: signInRequestModel.toJson(), ApiConstants.loginUrl));
      final signInResponsce=SignupResponseModel.fromJson(response.data);
      logger.d("sign in responsce __ ${signInResponsce.user.email}");
      await localStorage.savedToken(signInResponsce.token);
      await localStorage.saveUser(signInResponsce.user);
      return signInResponsce;
   } catch (e) {
     logger.e("error in Signin User $e");
     throw Exception("SignIn failed: $e");
   }
  }
  
}