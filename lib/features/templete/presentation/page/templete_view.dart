import 'package:flutter/material.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/form_page.dart';
import '../widget/templete/template_five.dart';
import '../widget/templete/template_four.dart';
import '../widget/templete/template_one.dart';
import '../widget/templete/template_three.dart';
import '../widget/templete/template_two.dart';



class TempleteView extends StatelessWidget {
  const TempleteView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> templates = [
          TemplateOne(name: "name",role: "role",blood: "A+",dob: "01/01/1990",email: "john@example.com",id: "123456",imagePath: "assets/images/profile.jpg",phone: "9876543210",),
          TemplateTwo(name: "name",role: "role",blood: "A+",dob: "01/01/1990",email: "john@example.com",id: "123456",imagePath: "assets/images/profile.jpg",phone: "9876543210",),
          TemplateThree(name: "name",role: "role",blood: "A+",dob: "01/01/1990",email: "john@example.com",id: "123456",imagePath: "assets/images/profile.jpg",phone: "9876543210",),
          TemplateFour(name: "name",role: "role",blood: "A+",dob: "01/01/1990",email: "john@example.com",id: "123456",imagePath: "assets/images/profile.jpg",phone: "9876543210",),
          TemplateFive(name: "name",role: "role",blood: "A+",dob: "01/01/1990",email: "john@example.com",id: "123456",imagePath: "assets/images/profile.jpg",phone: "9876543210",),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your ID Card Template')),
      body: ListView.builder(
        itemCount: templates.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormPage(
                    index: index,
                  ),
                ),
              );
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
