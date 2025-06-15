

import 'package:flutter/material.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/template_manager/template_manager.dart';

class GenerateTemplates extends StatefulWidget {
  const GenerateTemplates({super.key, required this.employees, required this.templateID});
  final List<Employee> employees;
  final int templateID ;

  @override
  State<GenerateTemplates> createState() => _GenerateTemplatesState();
}

class _GenerateTemplatesState extends State<GenerateTemplates> {

  @override
  void initState() {
    print("Received length is ${widget.employees.length}, Template ID is ${widget.templateID}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Templates'),
      ),
      body: widget.employees.isEmpty
        ? const Center(child: Text('No employees found. Please import data first.'))
        : ListView.separated(
          itemCount: widget.employees.length,
          itemBuilder: (context, index) {
            final employee = widget.employees[index];
            return _buildTemplate(employee, widget.templateID);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16,)
        ),
    );
  }

  Widget _buildTemplate(Employee employee, int templateID) {
    if(templateID < 0 || templateID >= TemplateManager.templatesWithDummy.length) {
      return const Center(child: Text('Invalid Template ID'));
    }
    return TemplateManager.getTemplateById(templateID, employee).template;
  }

}
