// lib/features/splash/presentation/manager/importer_bloc/importer_state.dart
part of 'importer_bloc.dart';

class ImporterState extends BlocEventState<List<Employee>> {
  const ImporterState({
    super.state = BlocState.none,
    super.event,
    super.data = const [],
    super.statusCode,
    super.error,
  });

  @override
  ImporterState copyWith({
    BlocState? state,
    BlocEvent? event,
    List<Employee>? data,
    int? statusCode,
    String? error,
  }) {
    return ImporterState(
      state: state ?? this.state,
      event: event ?? this.event,
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
    );
  }

  @override
  ImporterState clear() => const ImporterState();
}