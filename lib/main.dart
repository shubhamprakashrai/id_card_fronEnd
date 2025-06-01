import 'package:flutter/material.dart';
import 'package:id_card_front_end/features/signup/presentation/page/registration_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  RegistrationPageView(),
    );
  }
}

