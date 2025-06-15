import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:id_card_front_end/core/auth_global_cubit/auth_cubit.dart';
import 'package:id_card_front_end/core/di/service_locator.dart';
import 'package:id_card_front_end/core/router/app_router.dart';
import 'package:id_card_front_end/env/env_loader.dart';
import 'package:id_card_front_end/features/login/presentation/manager/sign_in_bloc.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvLoader.load();
  await Hive.initFlutter();
  await Hive.openBox<String>('authBox');
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<SignupBloc>()),
          BlocProvider(create: (context) => sl<AuthCubit>()),
          BlocProvider(
            create: (context) => sl<SignInBloc>(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ));
  }
}
