

import 'package:flutter/material.dart';

class TemplateWrapper extends StatelessWidget {
  const TemplateWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
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
      child: child,
    );
  }
}
