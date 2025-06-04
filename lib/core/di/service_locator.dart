import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:id_card_front_end/core/network/api_client.dart';
import 'package:id_card_front_end/features/signup/data/repository/signup_repository_implenetation.dart';
import 'package:id_card_front_end/features/signup/domain/respository/signup_base_repository.dart';
import 'package:id_card_front_end/features/signup/domain/usecases/user_signup_usecase.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_bloc.dart';

final sl = GetIt.instance;

void setupLocator() {

  // External
  sl.registerLazySingleton<Dio>(() => Dio());

  // Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>())); 

  // Repository
  sl.registerLazySingleton<SignupBaseRepository>(
    () => SignupRepositoryImplenetation(sl<ApiClient>()),
  );

  // Usecase
  sl.registerLazySingleton(() => UserSignupUsecase(sl()));

  // Bloc
  sl.registerFactory(() => SignupBloc(userSignupUsecase: sl()));


}
