import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortress_chat/core/components/auth_failures.dart';
import 'package:fortress_chat/features/authentication/domain/entities/user_entity.dart';
import 'package:fortress_chat/features/authentication/domain/use_cases/sign_up_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

part 'auth_signup_event.dart';
part 'auth_signup_state.dart';

@injectable
class AuthSignUpBloc extends Bloc<AuthSignUpEvent, AuthSignUpState> {
  final SignUpUsecase _signUp;
  AuthSignUpBloc({required this._signUp}) : super(AuthSignUpInitialState()) {
    on<AuthSignUpEvent>((event, emit) async {
      switch (event) {
        case AuthSigningUpEvent():
          emit(AuthSignUpLoadingState());
          final Either<AuthFailures, UserEntity> result = await _signUp(
            event.name,
            event.email,
            event.password,
          );
          result.fold(
            (failure) {
              emit(AuthSignUpFailureState(failure: failure));
            },
            (user) {
              emit(AuthSignUpSuccessState(userEntity: user));
            },
          );
      }
    });
  }
}
