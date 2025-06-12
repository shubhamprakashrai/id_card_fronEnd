import 'package:flutter/material.dart';

class TemplateThree extends StatelessWidget {
    const TemplateThree({super.key, required this.name, required this.role});
   final String name;
  final String role;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.purple.shade50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.business_center, size: 40, color: Colors.purple),
          SizedBox(height: 8),
          Text("Name: $name", style: const TextStyle(fontSize: 16)),
            Text("Role: $role", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
