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

  const Employee({
    required this.fullName,
    required this.designation,
    required this.department,
    required this.idNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.photoFileName,
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