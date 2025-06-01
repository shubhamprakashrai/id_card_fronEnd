import 'package:flutter/material.dart';
import 'package:id_card_front_end/core/ui_Utils/custom_btn.dart';
import 'package:id_card_front_end/core/ui_Utils/custom_textfield.dart';

class RegistrationPageView extends StatefulWidget{
  const RegistrationPageView({super.key});
  @override
  State<RegistrationPageView> createState(){
    return _RegistrationPageView();
  }
}

class _RegistrationPageView extends State<RegistrationPageView>{

  TextEditingController textEditingController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:
     SingleChildScrollView(
       child: Container(
         padding: const EdgeInsets.symmetric(horizontal: 40),
         height: MediaQuery.of(context).size.height - 50,
         width: double.infinity,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
             Column(
               children: <Widget>[
                 const SizedBox(height: 60.0),
                 const Text("Sign Up",
                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                 const SizedBox(height: 20),
                 Text("Create your account",
                     style: TextStyle(fontSize: 15, color: Colors.grey[700])),
               ],
             ),

             Column(
               children: [
                 const SizedBox(height: 20),
                 CustomTextField(
                   controller: textEditingController,
                   hintText: "Email",
                   errorText:"",
                   prefixIcon: const Icon(Icons.email),
                 ),
                 const SizedBox(height: 20),
                 CustomTextField(
                   controller: textEditingController,
                   hintText: "Password",
                   errorText: "",
                   prefixIcon: const Icon(Icons.lock_outline),
                   obscureText: true,
                 ),
                 const SizedBox(height: 20),
                 CustomTextField(
                   controller: textEditingController,
                   hintText: "Confirm Password",
                   errorText:"",
                   prefixIcon: const Icon(Icons.lock_outline),
                   obscureText: true,
                 )
               ],
             ),
             CustomLoadingButton(
               text: "Sign Up",
               isLoading: false,
               onPressed: () {
                 
               },
             ),

             const Center(child: Text("Or")),

             // Navigate to Login Page
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 const Text("Already have an account? "),
                 TextButton(
                     onPressed: () {
                      
                     },
                     child: const Text("Login",
                         style: TextStyle(color: Colors.purple))),
               ],
             )
           ],
         ),
       ),


     ),
   );
  }

}