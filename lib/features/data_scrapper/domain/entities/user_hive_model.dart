// lib/features/signup/data/models/user_hive_model.dart
import 'package:hive/hive.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';
part 'user_hive_model.g.dart';

@HiveType(typeId: 1) // Use a unique typeId (different from other Hive models)
class UserHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String role;

  UserHiveModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  // Convert from UserModel to UserHiveModel
  factory UserHiveModel.fromEntity(UserModel user) {
    return UserHiveModel(
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
    );
  }

  // Convert to UserModel
  UserModel toEntity() {
    return UserModel(
      id: id,
      name: name,
      email: email,
      role: role,
    );
  }

  // Convert from JSON
  factory UserHiveModel.fromJson(Map<String, dynamic> json) {
    return UserHiveModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}