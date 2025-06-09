import 'package:flutter/material.dart';
class TempleteView extends  StatefulWidget{
  const TempleteView({super.key});

  @override
  State<TempleteView> createState(){
    return _TempleteView();
  }
}

class _TempleteView extends State<TempleteView>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: Center(child: Text("Hi User please slect the id card")),
   );
  }

}