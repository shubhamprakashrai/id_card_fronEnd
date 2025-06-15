import 'dart:io';
import '../../data/models/employee.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> importEmployeesFromExcel(File file);
  Future<void> saveEmployees(List<Employee> employees);
}