part of 'generate_template_bloc.dart';

class GenerateTemplateEvent extends BlocEvent {

  const GenerateTemplateEvent();

}

class GeneratePdfEvent extends GenerateTemplateEvent {
  final List<Employee> employees;
  final int templateID;

  const GeneratePdfEvent({
    required this.employees,
    required this.templateID,
  });
}
