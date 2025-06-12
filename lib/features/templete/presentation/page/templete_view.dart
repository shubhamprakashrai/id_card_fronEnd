import 'package:flutter/material.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/form_page.dart';
// class TempleteView extends  StatefulWidget{
//   const TempleteView({super.key});

//   @override
//   State<TempleteView> createState(){
//     return _TempleteView();
//   }
// }

// class _TempleteView extends State<TempleteView>{
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//     body: Center(child: Text("Hi User please slect the id card")),
//    );
//   }

// }


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
          TemplateOne(name: "name",role: "role",),
          TemplateTwo(name: "name",role: "role",),
          TemplateThree(name: "name",role: "role",),
          TemplateFour(name: "name",role: "role",),
          TemplateFive(name: "name",role: "role",),
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
