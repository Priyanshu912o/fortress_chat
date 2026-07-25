import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortress_chat/core/components/auth_failures.dart';
import 'package:fortress_chat/features/authentication/domain/entities/user_entity.dart';
import 'package:fortress_chat/features/authentication/domain/use_cases/sign_in_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

part 'auth_signin_event.dart';
part 'auth_signin_state.dart';

@injectable
class AuthSignInBloc extends Bloc<AuthSignInEvent, AuthSignInState> {
  final SignInUsecase _signIn;

  AuthSignInBloc({required this._signIn}) : super(AuthSignInInitialState()) {
    on<AuthSignInEvent>((event, emit) async {
      switch (event) {
        case AuthSigningInEvent():
          emit(AuthSignInLoadingState());
          final Either<AuthFailures, UserEntity> result = await _signIn(
            event.email,
            event.password,
          );
          result.fold(
            (failure) {
              emit(AuthSignInFailureState(failure: failure));
            },
            (user) {
              emit(AuthSignInSuccessState(userEntity: user));
            },
          );
      }
    });
  }
}
