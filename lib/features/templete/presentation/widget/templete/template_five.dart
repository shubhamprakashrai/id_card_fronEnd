import 'package:flutter/material.dart';

class TemplateFive extends StatelessWidget {
  const TemplateFive({super.key, required this.name, required this.role});
   final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.red.shade50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_pin, size: 40, color: Colors.red),
          SizedBox(height: 8),
         Text("Name: $name", style: const TextStyle(fontSize: 16)),
            Text("Role: $role", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
