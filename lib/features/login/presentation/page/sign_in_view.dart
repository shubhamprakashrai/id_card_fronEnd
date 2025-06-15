import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/auth_global_cubit/auth_cubit.dart';
import 'package:id_card_front_end/core/router/route_names.dart';
import 'package:id_card_front_end/core/ui_Utils/custom_btn.dart';
import 'package:id_card_front_end/core/ui_Utils/custom_textfield.dart';
import 'package:id_card_front_end/core/utils/app_colors.dart';
import 'package:id_card_front_end/core/utils/show_snackbar.dart';
import 'package:id_card_front_end/features/login/data/models/sign_in_requestmodel.dart';
import 'package:id_card_front_end/features/login/presentation/manager/sign_in_bloc.dart';
import 'package:id_card_front_end/features/login/presentation/manager/sign_in_event.dart';
import 'package:id_card_front_end/features/login/presentation/manager/sign_in_state.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});
  @override
  State<SignInView> createState() {
    return _SignInView();
  }
}

class _SignInView extends State<SignInView> {
  final TextEditingController _textEditingEmailController =
      TextEditingController();
  final TextEditingController _textEditingPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SignInBloc, SignInState>(builder: (context, state) {
      return SafeArea(
        child: Center(
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
                  _inputField(context, state),
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
    }, listener: (context, state) async {
      if (state is SignInSucessState) {
        await context.read<AuthCubit>().updateAuthStatus(AuthStatus.authenticated);
        context.go(RouteName.template);
      } else if (state is SignInErrorState) {
        showSnackBar(context, "Login failed");
      }
    }));
  }

  Widget _inputField(BuildContext context, SignInState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: _textEditingEmailController,
          hintText: "Email",
          prefixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _textEditingPasswordController,
          hintText: "Password",
          prefixIcon: GestureDetector(
            onTap: () {},
            child: const Icon(Icons.lock_open),
          ),
          obscureText: true,
          onFieldSubmitted: (_) => {},
        ),
        const SizedBox(height: 10),
        CustomLoadingButton(
          text: "Login",
          isLoading: state is SignupProcessingState,
          onPressed: () {
            context.read<SignInBloc>().add(UserSignInEvent(
                signInRequestModel: SignInRequestModel(
                    email: _textEditingEmailController.text,
                    password: _textEditingPasswordController.text)));
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
              context.goNamed(RouteName.registration);
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: AppColors.purpleColors),
            ))
      ],
    );
  }
}
