import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  Widget preview;

   PreviewPage({
    super.key,
    required this.preview
  
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ID Card Preview")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 700,
            width: 550,
            child: preview),
        ),
      ),
    );
  }
}
