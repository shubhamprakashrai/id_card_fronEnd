import 'dart:io';
import 'package:excel/excel.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart' show Employee;
import 'package:id_card_front_end/features/data_scrapper/domain/repositories/employee_repository.dart' show EmployeeRepository;
import 'package:injectable/injectable.dart';

import '../../domain/exception/import_employees_exception.dart' show ImportEmployeesException;



@LazySingleton(as: EmployeeRepository)
class EmployeeRepositoryImpl implements EmployeeRepository {

  @override
  Future<List<Employee>> importEmployeesFromExcel(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final excel = Excel.decodeBytes(bytes);
      final List<Employee> employees = [];
      for (var table in excel.tables.keys) {
        final sheet = excel.tables[table]!;
        // Skip header row (index 0)
        for (var i = 1; i < sheet.rows.length; i++) {
          final row = sheet.rows[i];
          final employee = Employee(
            fullName: row[0]?.value.toString() ?? '',
            designation: row[1]?.value.toString() ?? '',
            department: row[2]?.value.toString() ?? '',
            idNumber: row[3]?.value.toString() ?? '',
            issueDate: row[4]?.value.toString() ?? '',
            expiryDate: row[5]?.value.toString() ?? '',
            photoFileName: row[6]?.value.toString() ?? '',
          );
          employees.add(employee);
        }
      }

      return employees;
    } catch (e, stackTrace) {
      throw ImportEmployeesException(
        message: 'Error parsing Excel file: ${e.toString()}',
        code: 1002,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveEmployees(List<Employee> employees) async {
    // Implement your save logic here (e.g., save to local database)
    // Example: await _database.insertEmployees(employees);
    await Future.delayed(const Duration(seconds: 1)); // Simulate save operation
  }
}