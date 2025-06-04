import 'package:dio/dio.dart';
import 'package:id_card_front_end/core/constants/api_constants.dart';
import 'package:id_card_front_end/core/network/api_client.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';
import 'package:id_card_front_end/features/signup/domain/respository/signup_base_repository.dart';

class SignupRepositoryImplenetation extends  SignupBaseRepository{
  final ApiClient apiClient;
  SignupRepositoryImplenetation(this.apiClient);
  @override
 Future<Response> signUpUser(SignupRequestModel model)async {
    return await apiClient.post(data: model.toJson(), ApiConstants.registerUrl,);
  }
 



}