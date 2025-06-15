
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
import 'package:id_card_front_end/features/data_scrapper/domain/entities/employee_hive_model.dart';

extension EmployeeHiveMapper on Employee {
  EmployeeHiveModel toHiveModel() {
    return EmployeeHiveModel.fromEntity(this);
  }
}

extension EmployeeEntityMapper on EmployeeHiveModel {
  Employee toEntity() {
    return Employee(
      fullName: fullName,
      designation: designation,
      department: department,
      idNumber: idNumber,
      issueDate: issueDate,
      expiryDate: expiryDate,
      photoFileName: photoFileName,
    );
  }
}