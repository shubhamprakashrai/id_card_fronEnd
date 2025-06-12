import 'package:flutter/material.dart';

class TemplateOne extends StatelessWidget {
  const TemplateOne({super.key, required this.name, required this.role});
   final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.blue.shade50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Icon(Icons.person, size: 40, color: Colors.blue),
          SizedBox(height: 8),
            Text("Name: $name", style: const TextStyle(fontSize: 16)),
            Text("Role: $role", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
