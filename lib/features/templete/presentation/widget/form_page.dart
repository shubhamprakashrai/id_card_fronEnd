import 'package:flutter/material.dart';
import 'preview_page.dart';
import 'templete/template_one.dart';
class FormPage extends StatefulWidget {
  final int index;
  const FormPage({super.key, required this.index});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final roleController = TextEditingController();

 Widget selectedWidget({required String name, required String role}){
   switch (widget.index) {
     case 0:
        return TemplateOne(name: name,role: role,);
      case 1:
       return TemplateOne(name: name,role: role,);
       case 2:
      return TemplateOne(name: name,role: role,);
        case 3:
        return TemplateOne(name: name,role: role,);
        case 4:
       return TemplateOne(name: name,role: role,);
       default:
        return const Text("Invalid template selected");
      

     
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fill Your Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Enter Name"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: "Enter Role"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final role = roleController.text.trim();

                if (name.isEmpty || role.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter both fields')),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PreviewPage(
                     preview: selectedWidget(name: name,role: role),
                    ),
                  ),
                );
              },
              child: const Text("Preview"),
            ),
          ],
        ),
      ),
    );
  }
}
