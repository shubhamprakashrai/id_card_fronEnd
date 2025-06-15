import 'dart:io';
import 'package:id_card_front_end/core/base/base_use_case/use_case.dart';
import 'package:id_card_front_end/features/data_scrapper/domain/entities/employee.dart';
import 'package:injectable/injectable.dart';
import 'package:id_card_front_end/features/data_scrapper/domain/repositories/employee_repository.dart';

import '../exception/importer_bloc_exception.dart';

@singleton
class ImportEmployeesUseCase implements UseCase<List<Employee>, File> {
  final EmployeeRepository repository;

  ImportEmployeesUseCase(this.repository);

  @override
  Future<List<Employee>?> call({required File params}) async {
    try{
      final result = await repository.importEmployeesFromExcel(params);
      return result;
    }on ImporterBlocException {
      rethrow;
    } catch (e, stackTrace) {
      throw ImporterBlocException(
        message: 'Failed to import employees: ${e.toString()}',
        code: 1001,
        stackTrace: stackTrace
      );
    }
  }
}