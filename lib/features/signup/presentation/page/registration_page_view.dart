import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/ui_Utils/custom_btn.dart';
import 'package:id_card_front_end/core/ui_Utils/custom_textfield.dart';
import 'package:id_card_front_end/core/utils/show_snackbar.dart';
import 'package:id_card_front_end/features/signup/data/models/signup_request_model.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_bloc.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_event.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_state.dart';

class RegistrationPageView extends StatefulWidget {
  const RegistrationPageView({super.key});
  @override
  State<RegistrationPageView> createState() {
    return _RegistrationPageView();
  }
}

class _RegistrationPageView extends State<RegistrationPageView> {
  final TextEditingController _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
 
 @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSucessState) {
          showSnackBar(context, "Signup successful!");
        } else if (state is SignupErrorState) {
          showSnackBar(context, "Register failed");
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
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
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Text("Create your account",
                        style:
                            TextStyle(fontSize: 15, color: Colors.grey[700])),
                  ],
                ),

                Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Name",
                      errorText: "",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                      errorText: "",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: _roleController,
                      hintText: "Role",
                      errorText: "",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      errorText: "",
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: true,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      errorText: "",
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: true,
                    )
                  ],
                ),
                CustomLoadingButton(
                  text: "Sign Up",
                  isLoading: state is SignupLoadingState,
                  onPressed: () {
                    if (_passwordController.text != _confirmPasswordController.text) {
                      showSnackBar(context, "Passwords do not match");
                      return;
                    }
                    context.read<SignupBloc>().add(
                          SignupUserEvent(
                            SignupRequestModel(
                              email: _emailController.text,
                              name: _nameController.text,
                              password: _passwordController.text,
                              role: _roleController.text,
                            ),
                          ),
                        );
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
                         context.go('/lgingPage');
                        },
                        child: const Text("Login", style: TextStyle(color: Colors.purple))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
