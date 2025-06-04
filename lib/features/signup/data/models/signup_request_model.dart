class SignupRequestModel {
  final String name;
  final String email;
  final String password;
  final String role;

  SignupRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
