// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
import '../local/local_Storage_base.dart' as _i49;
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
  gh.lazySingleton<_i735.SignupBaseRepository>(
      () => _i846.SignupRepositoryImplenetation(
            gh<_i557.ApiClient>(),
            gh<_i49.LocalStorage>(),
          ));
  gh.lazySingleton<_i874.SignInBaseRepositoty>(() => _i155.SignInRepository(
        gh<_i557.ApiClient>(),
        gh<_i49.LocalStorage>(),
      ));
  gh.lazySingleton<_i422.SignInUsecase>(
      () => _i422.SignInUsecase(gh<_i874.SignInBaseRepositoty>()));
  gh.factory<_i453.SignInBloc>(
      () => _i453.SignInBloc(signInUsecase: gh<_i422.SignInUsecase>()));
  gh.lazySingleton<_i516.UserSignupUsecase>(
      () => _i516.UserSignupUsecase(gh<_i735.SignupBaseRepository>()));
  gh.factory<_i907.SignupBloc>(
      () => _i907.SignupBloc(userSignupUsecase: gh<_i516.UserSignupUsecase>()));
  return getIt;
}
