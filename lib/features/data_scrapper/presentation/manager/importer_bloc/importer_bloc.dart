// lib/features/splash/presentation/manager/importer_bloc/importer_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/core/base/bloc_base/bloc_event.dart';
import 'package:id_card_front_end/core/base/bloc_base/bloc_event_state.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
import 'package:id_card_front_end/features/data_scrapper/domain/use_cases/import_employees_from_local_use_case.dart';
import 'package:id_card_front_end/features/data_scrapper/domain/use_cases/import_employees_usecase.dart';
import 'package:injectable/injectable.dart';

part 'importer_event.dart';
part 'importer_state.dart';

@injectable
class ImporterBloc extends Bloc<ImporterEvent, ImporterState> {
  final ImportEmployeesUseCase _importEmployeesUseCase;
  final ImportEmployeesFromLocalUseCase _employeesFromLocalUseCase;

  ImporterBloc(this._importEmployeesUseCase, this._employeesFromLocalUseCase) : super(const ImporterState()) {
    on<ImportExcelEvent>(_onImportExcel);
    on<ClearImportedDataEvent>(_onClearImportedData);
  }

  Future<void> _onImportExcel(
      ImportExcelEvent event,
      Emitter<ImporterState> emit,
      ) async {
    try {

      emit(state.copyWith(state: state.loading, event: event));

      final file = await _employeesFromLocalUseCase(params: 1);
      if(file == null){
        emit(state.clear());
      }
      final employees = await _importEmployeesUseCase(params: file!);
      if (employees != null && employees.isNotEmpty) {
        emit(
          state.copyWith(
            state: BlocState.success,
            data: employees,
          ),
        );
      } else {
        emit(
          state.copyWith(
            state: BlocState.failed,
            error: 'No employees found in the file',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          state: BlocState.failed,
          error: 'Failed to import Excel file: $e',
        ),
      );
    }
  }

  void _onClearImportedData(
      ClearImportedDataEvent event,
      Emitter<ImporterState> emit,
      ) {
    emit(const ImporterState());
  }
}