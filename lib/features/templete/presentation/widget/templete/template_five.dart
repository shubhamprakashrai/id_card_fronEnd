import 'package:flutter/material.dart';

import '../../../../data_scrapper/data/models/employee.dart';

class TemplateFive extends StatelessWidget {
  const TemplateFive({
    super.key,
    required this.employee,
  });
  final Employee employee;

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
         Text("Name: ${employee.fullName}", style: const TextStyle(fontSize: 16)),
            Text("Role: ${employee.designation}", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
