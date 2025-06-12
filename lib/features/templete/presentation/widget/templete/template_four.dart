import 'package:flutter/material.dart';

class TemplateFour extends StatelessWidget {
   const TemplateFour({super.key, required this.name, required this.role});
   final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.orange.shade50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, size: 40, color: Colors.orange),
          SizedBox(height: 8),
           Text("Name: $name", style: const TextStyle(fontSize: 16)),
            Text("Role: $role", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
