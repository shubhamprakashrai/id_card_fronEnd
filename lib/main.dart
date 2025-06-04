import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/core/di/service_locator.dart';
import 'package:id_card_front_end/core/router/app_router.dart';
import 'package:id_card_front_end/env/env_loader.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_bloc.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await EnvLoader.load();
   setupLocator();
  runApp(
    MultiBlocProvider(providers: [
    BlocProvider(create: (_) => sl<SignupBloc>()),
    
    ], child:  MyApp())
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
    );
  }
}

