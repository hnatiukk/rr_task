// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:rr_task/data/api/auth_api.dart' as _i128;
import 'package:rr_task/data/datasources/local/token_local_data_source.dart'
    as _i504;
import 'package:rr_task/data/datasources/remote/auth_remote_data_source.dart'
    as _i658;
import 'package:rr_task/data/repositories/auth_repository_impl.dart' as _i52;
import 'package:rr_task/di/register_module.dart' as _i483;
import 'package:rr_task/domain/repositories/auth_repository.dart' as _i398;
import 'package:rr_task/domain/usecases/auth_check_usecase.dart' as _i464;
import 'package:rr_task/domain/usecases/login_usecase.dart' as _i751;
import 'package:rr_task/domain/usecases/logout_usecase.dart' as _i598;
import 'package:rr_task/presentation/bloc/auth_bloc.dart' as _i588;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => registerModule.storage);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i128.AuthApi>(
      () => registerModule.authApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i504.TokenLocalDataSource>(
      () => _i504.TokenLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i658.AuthRemoteDataSource>(
      () => _i658.AuthRemoteDataSourceImpl(gh<_i128.AuthApi>()),
    );
    gh.lazySingleton<_i398.AuthRepository>(
      () => _i52.AuthRepositoryImpl(
        remoteDataSource: gh<_i658.AuthRemoteDataSource>(),
        localDataSource: gh<_i504.TokenLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i751.LoginUseCase>(
      () => _i751.LoginUseCase(gh<_i398.AuthRepository>()),
    );
    gh.lazySingleton<_i598.LogoutUseCase>(
      () => _i598.LogoutUseCase(gh<_i398.AuthRepository>()),
    );
    gh.lazySingleton<_i464.AuthCheckUseCase>(
      () => _i464.AuthCheckUseCase(gh<_i398.AuthRepository>()),
    );
    gh.factory<_i588.AuthBloc>(
      () => _i588.AuthBloc(
        loginUseCase: gh<_i751.LoginUseCase>(),
        logoutUseCase: gh<_i598.LogoutUseCase>(),
        authCheckUseCase: gh<_i464.AuthCheckUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i483.RegisterModule {}
