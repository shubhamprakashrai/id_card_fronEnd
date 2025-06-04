import 'package:dio/dio.dart';
import 'package:id_card_front_end/core/constants/api_constants.dart';
import 'package:id_card_front_end/core/network/api_client.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';
import 'package:id_card_front_end/features/signup/domain/respository/signup_base_repository.dart';

class SignupRepositoryImplenetation extends  SignupBaseRepository{
  
  final ApiClient apiClient;

  SignupRepositoryImplenetation(this.apiClient);

  @override
  Future<Response> signUpUser(SignupRequestModel model) async {
    try {
      return await apiClient.post(data: model.toJson(), ApiConstants.registerUrl);
    } catch (e) {
      print("Signup API error: $e");
      // Don't return a `Failure`, throw it if you must handle it
      throw Exception("Signup failed: $e");
    }
  }
  
}