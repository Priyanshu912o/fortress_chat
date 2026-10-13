import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:Fortress/features/settings/domain/entities/user_profile_entity.dart';
import 'package:Fortress/features/settings/domain/repositories/settings_repository.dart';
import 'package:Fortress/features/settings/domain/usecases/clear_local_cache_usecase.dart';
import 'package:Fortress/features/settings/domain/usecases/delete_account_usecase.dart';
import 'package:Fortress/features/settings/domain/usecases/get_current_user_usecase.dart';
import 'package:Fortress/features/settings/domain/usecases/sign_out_usecase.dart';
import 'package:Fortress/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:Fortress/features/settings/presentation/bloc/settings_event.dart';
import 'package:Fortress/core/components/chat_failures.dart';

class MockSettingsRepository implements SettingsRepository {
  UserProfileEntity? mockUser;
  bool cacheCleared = false;
  bool signedOut = false;
  bool accountDeleted = false;

  @override
  Future<Either<ChatFailures, UserProfileEntity?>> getCurrentUser() async {
    return Right(mockUser);
  }

  @override
  Future<Either<ChatFailures, Unit>> clearLocalCache() async {
    cacheCleared = true;
    return const Right(unit);
  }

  @override
  Future<Either<ChatFailures, Unit>> signOut() async {
    signedOut = true;
    return const Right(unit);
  }

  @override
  Future<Either<ChatFailures, Unit>> deleteAccount() async {
    accountDeleted = true;
    return const Right(unit);
  }
}

void main() {
  group('Settings Clean Architecture & BLoC Tests', () {
    late MockSettingsRepository mockRepo;
    late GetCurrentUserUsecase getCurrentUserUsecase;
    late ClearLocalCacheUsecase clearLocalCacheUsecase;
    late SignOutUsecase signOutUsecase;
    late DeleteAccountUsecase deleteAccountUsecase;
    late SettingsBloc bloc;

    setUp(() {
      mockRepo = MockSettingsRepository();
      getCurrentUserUsecase = GetCurrentUserUsecase(mockRepo);
      clearLocalCacheUsecase = ClearLocalCacheUsecase(mockRepo);
      signOutUsecase = SignOutUsecase(mockRepo);
      deleteAccountUsecase = DeleteAccountUsecase(mockRepo);
      bloc = SettingsBloc(
        getCurrentUserUsecase,
        clearLocalCacheUsecase,
        signOutUsecase,
        deleteAccountUsecase,
      );
    });

    test('LoadSettings emits currentUser from domain use case', () async {
      mockRepo.mockUser = const UserProfileEntity(
        uid: 'user_123',
        email: 'alice@fortress.chat',
        displayName: 'Alice',
      );

      bloc.add(const LoadSettings());

      await expectLater(
        bloc.stream,
        emits(predicate<dynamic>((state) =>
            state.currentUser?.uid == 'user_123' &&
            state.currentUser?.displayName == 'Alice')),
      );
    });

    test('ClearLocalCacheEvent delegates to ClearLocalCacheUsecase', () async {
      bloc.add(const ClearLocalCacheEvent());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<dynamic>((state) => state.isClearingCache == true),
          predicate<dynamic>((state) =>
              state.isClearingCache == false &&
              state.message == 'Offline cache cleared successfully.'),
        ]),
      );

      expect(mockRepo.cacheCleared, isTrue);
    });
  });
}
