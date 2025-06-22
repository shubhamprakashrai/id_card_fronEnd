// lib/core/service/hive_storage.dart
import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:id_card_front_end/features/data_scrapper/data/mappers/user_model_hive_model_mapper.dart';
import 'package:id_card_front_end/features/data_scrapper/domain/entities/employee_hive_model.dart';
import 'package:id_card_front_end/features/data_scrapper/domain/entities/user_hive_model.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_response_model.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;


class HiveStorage {
  static const String _authBoxName = 'auth_box';
  static const String _employeeBoxName = 'employee_box';
  static const String _userBoxName = 'user_box';

  late final Box _authBox;
  late final Box<EmployeeHiveModel> _employeeBox;
  late final Box<UserHiveModel> _userBox; // Add this line

  static late final HiveStorage instance;

  static Future<void> init() async {
    instance = HiveStorage._();
    await instance._initHive();
  }

  HiveStorage._();

  Future<void> _initHive() async {
    _registerAdapters();
    await _openBoxes(); // Add this line
  }

  FutureOr<void> _openBoxes() async {

    // Wrap fill method in try catch to handle any exceptions
    // and log the error if needed
    try {
      final dir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(dir.path);
      _authBox = await Hive.openBox(_authBoxName);
      _employeeBox = await Hive.openBox<EmployeeHiveModel>(_employeeBoxName);
      _userBox = await Hive.openBox<UserHiveModel>(_userBoxName);
    } catch (e) {
      // print('Error opening Hive boxes: $e');
    }
  }

  void _registerAdapters() {
    Hive.registerAdapter(EmployeeHiveModelAdapter());
    Hive.registerAdapter(UserHiveModelAdapter());
  }



  Future<void> saveUser(UserModel user) => _userBox.put('current_user', user.toHiveModel());
  UserHiveModel? getCurrentUser() => _userBox.get('current_user');
  Future<void> clearUser() => _userBox.clear();

  // Auth box methods
  Future<void> setAuthToken(String token) => _authBox.put('token', token);
  String? get authToken => _authBox.get('token');
  Future<void> clearAuth() => _authBox.clear();

  // Employee box methods
  Future<void> saveEmployee(EmployeeHiveModel employee) => _employeeBox.add(employee);
  Future<void> saveEmployees(List<EmployeeHiveModel> employees) => _employeeBox.addAll(employees);
  List<EmployeeHiveModel> getAllEmployees() => _employeeBox.values.toList();
  Future<void> clearEmployees() => _employeeBox.clear();

  Future<void> clearAll() async {
    await clearAuth();
    await clearUser();
    await clearEmployees();
  }

  Future<void> dispose() async {
    await _authBox.close();
    await _employeeBox.close();
    await _userBox.close();
  }

  Future<void> clearStorage() => clearAll();

  Future<String?> getToken() => Future.value(authToken);

  Future<UserModel?> getUser() {
    var res = getCurrentUser();
    if (res == null) {
      return Future.value(null);
    }
    return Future.value(UserModel.fromJson(res.toJson()));
  }

  Future<void> savedToken(String token) => setAuthToken(token);
}