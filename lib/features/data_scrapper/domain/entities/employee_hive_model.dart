// lib/features/data_scrapper/data/models/employee_hive_model.dart
import 'package:hive/hive.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
part 'employee_hive_model.g.dart';

@HiveType(typeId: 0)
class EmployeeHiveModel extends HiveObject {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String designation;

  @HiveField(2)
  final String department;

  @HiveField(3)
  final String idNumber;

  @HiveField(4)
  final String issueDate;

  @HiveField(5)
  final String expiryDate;

  @HiveField(6)
  final String photoFileName;

  @HiveField(7)
  final String mobileNumber;

  @HiveField(8)
  final String bloodGroup;

  @HiveField(9)
  final String dob;

  @HiveField(10)
  final String email;


  EmployeeHiveModel({
    required this.fullName,
    required this.designation,
    required this.department,
    required this.idNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.photoFileName,
    this.mobileNumber = '',
    this.bloodGroup = '',
    this.dob = '',
    this.email = '',
  });

  // Convert from Entity to Hive Model
  factory EmployeeHiveModel.fromEntity(Employee entity) {
    return EmployeeHiveModel(
      fullName: entity.fullName,
      designation: entity.designation,
      department: entity.department,
      idNumber: entity.idNumber,
      issueDate: entity.issueDate,
      expiryDate: entity.expiryDate,
      photoFileName: entity.photoFileName,
      mobileNumber: entity.mobileNumber,
      bloodGroup: entity.bloodGroup,
      dob: entity.dob,
      email: entity.email,
    );
  }

  // Convert to Entity
  Employee toEntity() {
    return Employee(
      fullName: fullName,
      designation: designation,
      department: department,
      idNumber: idNumber,
      issueDate: issueDate,
      expiryDate: expiryDate,
      photoFileName: photoFileName,
      mobileNumber: mobileNumber,
      bloodGroup: bloodGroup,
      dob: dob,
      email: email,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EmployeeHiveModel &&
              runtimeType == other.runtimeType &&
              fullName == other.fullName &&
              designation == other.designation &&
              department == other.department &&
              idNumber == other.idNumber &&
              issueDate == other.issueDate &&
              expiryDate == other.expiryDate &&
              photoFileName == other.photoFileName &&
              mobileNumber == other.mobileNumber &&
              bloodGroup == other.bloodGroup &&
              dob == other.dob &&
              email == other.email;

  @override
  int get hashCode =>
      fullName.hashCode ^
      designation.hashCode ^
      department.hashCode ^
      idNumber.hashCode ^
      issueDate.hashCode ^
      expiryDate.hashCode ^
      photoFileName.hashCode ^
      mobileNumber.hashCode ^
      bloodGroup.hashCode ^
      dob.hashCode ^
      email.hashCode;
}