import 'package:flutter/material.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/templete/template_five.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/templete/template_four.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/templete/template_one.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/templete/template_three.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/templete/template_two.dart';

class TemplateManager{

  static Employee get dummyEmployee => Employee(
    fullName: 'John Doe',
    designation: 'Senior Developer',
    department: 'Engineering',
    idNumber: 'EMP-007',
    issueDate: '01/01/2024',
    expiryDate: '31/12/2025',
    photoFileName: '',
  );


  static List<String> get templateNames => [
    'Template One',
    'Template Two',
    'Template Three',
    'Template Four',
    'Template Five',
  ];

  static List<TemplateModel> templates(Employee employee){
    return [
      TemplateModel(name: templateNames[0], template: TemplateOne(employee: employee)),
      TemplateModel(name: templateNames[1], template: TemplateTwo(employee: employee)),
      TemplateModel(name: templateNames[2], template: TemplateThree(employee: employee)),
      TemplateModel(name: templateNames[3], template: TemplateFour(employee: employee)),
      TemplateModel(name: templateNames[4], template: TemplateFive(employee: employee)),
    ];
  }

  static TemplateModel getTemplateById(int id, Employee employee) {
    if (id < 0 || id >= templateNames.length) {
      throw ArgumentError('Invalid template ID: $id');
    }
    return TemplateModel(name: templateNames[id], template: templates(employee)[id].template);
  }

  static List<TemplateModel> get templatesWithDummy{
    return [
      TemplateModel(name: templateNames[0], template: TemplateOne(employee: dummyEmployee)),
      TemplateModel(name: templateNames[1], template: TemplateTwo(employee: dummyEmployee)),
      TemplateModel(name: templateNames[2], template: TemplateThree(employee: dummyEmployee)),
      TemplateModel(name: templateNames[3], template: TemplateFour(employee: dummyEmployee)),
      TemplateModel(name: templateNames[4], template: TemplateFive(employee: dummyEmployee)),
    ];
  }
}

class TemplateModel{
  final String name;
  final Widget template;
  const TemplateModel({
    required this.name,
    required this.template,
  });
}