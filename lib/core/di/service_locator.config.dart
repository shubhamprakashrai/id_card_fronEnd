// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/data_scrapper/data/repositories/employee_repository_impl.dart'
    as _i588;
import '../../features/data_scrapper/domain/repositories/employee_repository.dart'
    as _i612;
import '../../features/data_scrapper/domain/use_cases/import_employees_from_local_use_case.dart'
    as _i519;
import '../../features/data_scrapper/domain/use_cases/import_employees_usecase.dart'
    as _i166;
import '../../features/data_scrapper/presentation/manager/importer_bloc/importer_bloc.dart'
    as _i1069;
import '../../features/generate_templates/domain/use_cases/check_storage_permission_use_case.dart'
    as _i1014;
import '../../features/generate_templates/presentation/manager/generate_templates/generate_template_bloc.dart'
    as _i78;
import '../../features/login/data/repository/sign_in_repository.dart' as _i155;
import '../../features/login/domain/repository/sign_in_base_repository.dart'
    as _i874;
import '../../features/login/domain/usecase/user_sign_in_usecase.dart' as _i422;
import '../../features/login/presentation/manager/sign_in_bloc.dart' as _i453;
import '../../features/signup/data/repository/signup_repository_implenetation.dart'
    as _i846;
import '../../features/signup/domain/respository/signup_base_repository.dart'
    as _i735;
import '../../features/signup/domain/usecases/user_signup_usecase.dart'
    as _i516;
import '../../features/signup/presentation/bloc/signup_bloc.dart' as _i907;
import '../auth_global_cubit/auth_cubit.dart' as _i564;
import '../network/api_client.dart' as _i557;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt inject(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i564.AuthCubit>(() => _i564.AuthCubit());
  gh.singleton<_i519.ImportEmployeesFromLocalUseCase>(
      () => const _i519.ImportEmployeesFromLocalUseCase());
  gh.lazySingleton<_i557.ApiClient>(() => _i557.ApiClient());
  gh.lazySingleton<_i1014.CheckStoragePermissionUseCase>(
      () => const _i1014.CheckStoragePermissionUseCase());
  gh.lazySingleton<_i612.EmployeeRepository>(
      () => _i588.EmployeeRepositoryImpl());
  gh.singleton<_i166.ImportEmployeesUseCase>(
      () => _i166.ImportEmployeesUseCase(gh<_i612.EmployeeRepository>()));
  gh.lazySingleton<_i735.SignupBaseRepository>(
      () => _i846.SignupRepositoryImplenetation(gh<_i557.ApiClient>()));
  gh.lazySingleton<_i874.SignInBaseRepositoty>(
      () => _i155.SignInRepository(gh<_i557.ApiClient>()));
  gh.factory<_i1069.ImporterBloc>(() => _i1069.ImporterBloc(
        gh<_i166.ImportEmployeesUseCase>(),
        gh<_i519.ImportEmployeesFromLocalUseCase>(),
      ));
  gh.factory<_i78.GenerateTemplateBloc>(() =>
      _i78.GenerateTemplateBloc(gh<_i1014.CheckStoragePermissionUseCase>()));
  gh.lazySingleton<_i516.UserSignupUsecase>(
      () => _i516.UserSignupUsecase(gh<_i735.SignupBaseRepository>()));
  gh.lazySingleton<_i422.SignInUsecase>(
      () => _i422.SignInUsecase(gh<_i874.SignInBaseRepositoty>()));
  gh.factory<_i907.SignupBloc>(
      () => _i907.SignupBloc(userSignupUsecase: gh<_i516.UserSignupUsecase>()));
  gh.factory<_i453.SignInBloc>(
      () => _i453.SignInBloc(signInUsecase: gh<_i422.SignInUsecase>()));
  return getIt;
}
