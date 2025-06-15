// lib/features/splash/presentation/manager/importer_bloc/importer_bloc.dart
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/core/base/bloc_base/bloc_event.dart';
import 'package:id_card_front_end/core/base/bloc_base/bloc_event_state.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
import 'package:id_card_front_end/features/data_scrapper/domain/use_cases/import_employees_usecase.dart';
import 'package:injectable/injectable.dart';

part 'importer_event.dart';
part 'importer_state.dart';

@injectable
class ImporterBloc extends Bloc<ImporterEvent, ImporterState> {
  final ImportEmployeesUseCase _importEmployeesUseCase;

  ImporterBloc(this._importEmployeesUseCase) : super(const ImporterState()) {
    on<ImportExcelEvent>(_onImportExcel);
    on<ClearImportedDataEvent>(_onClearImportedData);
  }

  Future<void> _onImportExcel(
      ImportExcelEvent event,
      Emitter<ImporterState> emit,
      ) async {
    emit(state.copyWith(state: BlocState.loading));
    try {
      final employees = await _importEmployeesUseCase(params: event.file);
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