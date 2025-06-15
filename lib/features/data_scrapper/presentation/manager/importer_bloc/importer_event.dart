// lib/features/splash/presentation/manager/importer_bloc/importer_event.dart
part of 'importer_bloc.dart';

abstract class ImporterEvent extends BlocEvent {
  const ImporterEvent();
}

class ImportExcelEvent extends ImporterEvent {
  final File file;
  const ImportExcelEvent(this.file);
}

class ClearImportedDataEvent extends ImporterEvent {
  const ClearImportedDataEvent();
}