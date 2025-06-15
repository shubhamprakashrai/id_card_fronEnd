import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/auth_global_cubit/auth_cubit.dart';
import 'package:id_card_front_end/core/router/route_names.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  FutureOr<void> _checkAuthStatus() async {
    print("Checking auth status...");
    var res = await context.read<AuthCubit>().checkAuthStatus();
    print("Auth status checked: $res");
    Future.delayed(Duration(seconds: 2), () {
      if(res){
        context.goNamed(RouteName.template);
      }
      else{
        context.goNamed(RouteName.login);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStatus>(
      listener: (context, state) {
        print("Auth status changed: $state");
        if(state.isAuthenticated){
          context.goNamed(RouteName.template);
        }
        else{
          context.goNamed(RouteName.login);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                'Loading...',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
