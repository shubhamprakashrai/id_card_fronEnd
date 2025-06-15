

import 'package:id_card_front_end/features/data_scrapper/domain/entities/user_hive_model.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';

extension UserModelHiveMapper on UserModel {
  UserHiveModel toHiveModel() {
    return UserHiveModel.fromEntity(this);
  }
}

extension HiveUserToModel on UserHiveModel{
  UserModel toModel() {
    return UserModel(
      id: id,
      email: email,
      role: role,
      name: name,
    );
  }
}