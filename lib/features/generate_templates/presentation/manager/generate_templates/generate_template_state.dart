part of 'generate_template_bloc.dart';

class GenerateTemplateState extends BlocEventState<List<Employee>> {

  final BaseException? exception;
  final File? file;

  const GenerateTemplateState({
    super.data,
    super.error,
    super.event,
    super.state,
    super.statusCode,
    this.exception,
    this.file,
  });

  @override
  GenerateTemplateState clear() => GenerateTemplateState();

  @override
  GenerateTemplateState copyWith({
    List<Employee>? data,
    String? error,
    BlocEvent? event,
    BlocState? state,
    int? statusCode,
    BaseException? exception,
    File? file,
  }) {
    return GenerateTemplateState(
      data: data ?? this.data,
      error: error ?? this.error,
      event: event ?? this.event,
      state: state ?? this.state,
      statusCode: statusCode ?? this.statusCode,
      exception: exception,
      file: file ?? this.file,
    );
  }

  bool get isPermissionNotGranted => exception is PermissionNotFoundException;
}

