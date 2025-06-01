import 'package:flutter/material.dart';
import 'package:id_card_front_end/core/ui_Utils/custom_btn.dart';
import 'package:id_card_front_end/core/ui_Utils/custom_textfield.dart';
import 'package:id_card_front_end/core/utils/app_colors.dart';

class SignInView extends StatefulWidget{
  const SignInView({super.key});
  @override
  State<SignInView> createState(){
    return _SignInView();
  }
}
class _SignInView extends State<SignInView>{
  TextEditingController textEditingControllerOfLoginFiled=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 30,
                ),
                _header(context),
                const SizedBox(
                  height: 10,
                ),
                _inputField(context),
                const SizedBox(
                  height: 20,
                ),
                // _forgotPassword(context),
                const SizedBox(
                  height: 20,
                ),
                // SizedBox(
                //   width: 180,
                //   child: SignInButtonGoogle(
                //     label: "Sign In With Google",
                //     onPressed: () async {
                //       Get.off(const HomePageView(), binding: HomePageBinding());
                //       // await GoogleAuthService.signInWithGoogle();
                //     },
                //   ),
                // ),
                _signup(context),
              ],
            ),
          ),
        ),
      
      
      ),
    );
  }


 Widget _inputField(BuildContext context) {
  
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller:textEditingControllerOfLoginFiled,
          hintText: "Email",
          prefixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: textEditingControllerOfLoginFiled,
          hintText: "Password",
          prefixIcon: GestureDetector(
            onTap: () {

            },
            child: const Icon(Icons.lock_open),
          ),
          obscureText: true,
          onFieldSubmitted: (_) => {},
        ),
        const SizedBox(height: 10),
        CustomLoadingButton(
              text: "Login",
              isLoading: false,
              onPressed: () {
               
              },
            )
      ],
    );
  }

Widget _header(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }

  //  Widget _forgotPassword(BuildContext context) {
  //   return TextButton(
  //     onPressed: () {
  //       // Get.to(
  //       //   () => const ForgetPasswordView(),
  //       //   binding: ForgetpasswordBinding(),
  //       // );
  //     },
  //     child: const Text(
  //       "Forget Password?",
  //       style: TextStyle(color: AppColors.purpleColors),
  //     ),
  //   );
  // }
   Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
            onPressed: () {
            
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: AppColors.purpleColors),
            ))
      ],
    );
  }
    
}