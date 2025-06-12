import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:id_card_front_end/core/auth_global_cubit/auth_cubit.dart';
import 'package:id_card_front_end/core/local/hive_local_storage.dart';
import 'package:id_card_front_end/core/local/local_Storage_base.dart';
import 'package:id_card_front_end/core/network/api_client.dart';
import 'package:id_card_front_end/features/login/data/repository/sign_in_repository.dart';
import 'package:id_card_front_end/features/login/domain/repository/sign_in_base_repository.dart';
import 'package:id_card_front_end/features/login/domain/usecase/user_sign_in_usecase.dart';
import 'package:id_card_front_end/features/login/presentation/manager/sign_in_bloc.dart';
import 'package:id_card_front_end/features/signup/data/repository/signup_repository_implenetation.dart';
import 'package:id_card_front_end/features/signup/domain/respository/signup_base_repository.dart';
import 'package:id_card_front_end/features/signup/domain/usecases/user_signup_usecase.dart';
import 'package:id_card_front_end/features/signup/presentation/bloc/signup_bloc.dart';

final sl = GetIt.instance;

void setupLocator() {

  // External
  sl.registerLazySingleton<Dio>(() => Dio());
  
  sl.registerLazySingleton<LocalStorage>(() => HiveStorage());
  sl.registerLazySingleton<HiveStorage>(() => HiveStorage());

  sl.registerLazySingleton(() => AuthCubit(sl<HiveStorage>()));
     
  // Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>())); 

  
  // Repository
   sl.registerLazySingleton<SignupBaseRepository>( () => SignupRepositoryImplenetation(sl<ApiClient>(), sl<LocalStorage>(), ),);

  // Usecase
  sl.registerLazySingleton(() => UserSignupUsecase(sl()));

  // Bloc
  sl.registerFactory(() => SignupBloc(userSignupUsecase: sl()));

  // ++++++++++++++ Login dependency here ++++++++++++++

  sl.registerLazySingleton<SignInBaseRepositoty> (()=>SignInRepository(sl<ApiClient>(), sl<LocalStorage>(),),);
  sl.registerLazySingleton<SignInUsecase>(() => SignInUsecase(sl<SignInBaseRepositoty>()));
  sl.registerFactory(() => SignInBloc(signInUsecase: sl<SignInUsecase>()));

}
