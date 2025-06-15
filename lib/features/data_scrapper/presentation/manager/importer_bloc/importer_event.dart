// lib/features/splash/presentation/manager/importer_bloc/importer_event.dart
part of 'importer_bloc.dart';

abstract class ImporterEvent extends BlocEvent {
  const ImporterEvent();
}

class ImportExcelEvent extends ImporterEvent {
  const ImportExcelEvent();
}

class ClearImportedDataEvent extends ImporterEvent {
  const ClearImportedDataEvent();
}