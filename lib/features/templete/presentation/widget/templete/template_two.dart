import 'package:flutter/material.dart';

class TemplateTwo extends StatelessWidget {

  const TemplateTwo({
    super.key,
    required this.name,
    required this.role,
    required this.id,
    required this.dob,
    required this.blood,
    required this.phone,
    required this.email,
    required this.imagePath,
  });

  final String name;
  final String role;
  final String id;
  final String dob;
  final String blood;
  final String phone;
  final String email;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.green.shade50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 20, backgroundColor: Colors.green),
          SizedBox(height: 8),
           Text("Name: $name", style: const TextStyle(fontSize: 16)),
            Text("Role: $role", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
