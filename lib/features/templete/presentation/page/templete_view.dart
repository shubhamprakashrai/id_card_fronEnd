import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/router/route_names.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
import '../widget/templete/template_five.dart';
import '../widget/templete/template_four.dart';
import '../widget/templete/template_one.dart';
import '../widget/templete/template_three.dart';
import '../widget/templete/template_two.dart';



class TemplateView extends StatefulWidget {
  const TemplateView({super.key});

  @override
  State<TemplateView> createState() => _TemplateViewState();
}

class _TemplateViewState extends State<TemplateView> {
  // Dummy employee data
  Employee get dummyEmployee => Employee(
    fullName: 'John Doe',
    designation: 'Senior Developer',
    department: 'Engineering',
    idNumber: 'EMP-007',
    issueDate: '01/01/2024',
    expiryDate: '31/12/2025',
    photoFileName: '', // Make sure this asset exists
    // Add any other required fields from your Employee model
  );

  @override
  Widget build(BuildContext context) {



    final List<Widget> templates = [
      TemplateOne(employee: dummyEmployee),
      TemplateTwo(employee: dummyEmployee),
      TemplateThree(employee: dummyEmployee),
      TemplateFour(employee: dummyEmployee),
      TemplateFive(employee: dummyEmployee),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your ID Card Template'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(RouteName.importExcelPage);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: templates.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.pushNamed(RouteName.formView, extra: index);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 600,
                child: templates[index],
              ),
            ),
          );
        },
      ),
    );
  }
}