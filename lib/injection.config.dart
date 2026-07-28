// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_links/app_links.dart' as _i327;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'app_router.dart' as _i313;
import 'core/utils/register_modules.dart' as _i864;
import 'features/authentication/data/data_sources/auth_remote_data_source.dart'
    as _i373;
import 'features/authentication/data/data_sources/auth_remote_data_source_impl.dart'
    as _i774;
import 'features/authentication/data/repository/auth_repository_impl.dart'
    as _i910;
import 'features/authentication/domain/repository/auth_repository.dart'
    as _i938;
import 'features/authentication/domain/use_cases/check_email_verification_usecase.dart'
    as _i733;
import 'features/authentication/domain/use_cases/reset_pasword_usecase.dart'
    as _i492;
import 'features/authentication/domain/use_cases/send_reset_password_email_usecase.dart'
    as _i687;
import 'features/authentication/domain/use_cases/sign_in_usecase.dart' as _i925;
import 'features/authentication/domain/use_cases/sign_out_usecase.dart'
    as _i504;
import 'features/authentication/domain/use_cases/sign_up_usecase.dart' as _i907;
import 'features/authentication/domain/use_cases/verify_email_usecase.dart'
    as _i757;
import 'features/authentication/presentation/blocs/global_auth_bloc/authentication_bloc.dart'
    as _i546;
import 'features/authentication/presentation/blocs/signin_bloc/auth_signin_bloc.dart'
    as _i193;
import 'features/authentication/presentation/blocs/signup_bloc/auth_signup_bloc.dart'
    as _i462;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModules = _$RegisterModules();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModules.firebaseAuth);
    gh.lazySingleton<_i327.AppLinks>(() => registerModules.appLinks);
    gh.lazySingleton<_i373.AuthRemoteDataSource>(
      () => _i774.AuthRemoteDataSourceImpl(auth: gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i938.AuthRepository>(
      () => _i910.AuthRepositoryImpl(
        remoteAuth: gh<_i373.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i733.CheckEmailVerificationUsecase>(
      () => _i733.CheckEmailVerificationUsecase(gh<_i938.AuthRepository>()),
    );
    gh.lazySingleton<_i492.ResetPaswordUsecase>(
      () => _i492.ResetPaswordUsecase(gh<_i938.AuthRepository>()),
    );
    gh.lazySingleton<_i687.SendResetPasswordEmailUsecase>(
      () => _i687.SendResetPasswordEmailUsecase(gh<_i938.AuthRepository>()),
    );
    gh.lazySingleton<_i925.SignInUsecase>(
      () => _i925.SignInUsecase(gh<_i938.AuthRepository>()),
    );
    gh.lazySingleton<_i504.SignOutUsecase>(
      () => _i504.SignOutUsecase(gh<_i938.AuthRepository>()),
    );
    gh.lazySingleton<_i907.SignUpUsecase>(
      () => _i907.SignUpUsecase(gh<_i938.AuthRepository>()),
    );
    gh.lazySingleton<_i757.VerifyEmailUsecase>(
      () => _i757.VerifyEmailUsecase(gh<_i938.AuthRepository>()),
    );
    gh.factory<_i462.AuthSignUpBloc>(
      () => _i462.AuthSignUpBloc(signUp: gh<_i907.SignUpUsecase>()),
    );
    gh.factory<_i193.AuthSignInBloc>(
      () => _i193.AuthSignInBloc(signIn: gh<_i925.SignInUsecase>()),
    );
    gh.lazySingleton<_i546.AuthenticationBloc>(
      () => _i546.AuthenticationBloc(
        checkEmailVerification: gh<_i733.CheckEmailVerificationUsecase>(),
        verifyEmail: gh<_i757.VerifyEmailUsecase>(),
        sendResetPasswordEmailUsecase:
            gh<_i687.SendResetPasswordEmailUsecase>(),
        signOut: gh<_i504.SignOutUsecase>(),
        repository: gh<_i938.AuthRepository>(),
        resetPasword: gh<_i492.ResetPaswordUsecase>(),
      ),
    );
    gh.lazySingleton<_i313.AppRouter>(
      () => _i313.AppRouter(
        authBloc: gh<_i546.AuthenticationBloc>(),
        appLinks: gh<_i327.AppLinks>(),
      ),
    );
    return this;
  }
}

class _$RegisterModules extends _i864.RegisterModules {}
