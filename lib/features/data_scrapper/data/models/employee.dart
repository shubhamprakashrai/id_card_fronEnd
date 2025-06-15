// lib/features/data_scrapper/domain/entities/employee.dart
import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String fullName;
  final String designation;
  final String department;
  final String idNumber;
  final String issueDate;
  final String expiryDate;
  final String photoFileName;
  final String mobileNumber;
  final String bloodGroup;
  final String dob;
  final String email;

  const Employee({
    required this.fullName,
    required this.designation,
    required this.department,
    required this.idNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.photoFileName,
    this.bloodGroup = '',
    this.dob = '',
    this.mobileNumber = '',
    this.email = '',
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      fullName: json['fullName'] ?? '',
      designation: json['designation'] ?? '',
      department: json['department'] ?? '',
      idNumber: json['idNumber']?.toString() ?? '',
      issueDate: json['issueDate'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      photoFileName: json['photoFileName'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      dob: json['dob'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'designation': designation,
      'department': department,
      'idNumber': idNumber,
      'issueDate': issueDate,
      'expiryDate': expiryDate,
      'photoFileName': photoFileName,
      'bloodGroup': bloodGroup,
      'dob': dob,
      'mobileNumber': mobileNumber,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [
        fullName,
        designation,
        department,
        idNumber,
        issueDate,
        expiryDate,
        photoFileName,
      ];
}