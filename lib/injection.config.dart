// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:app_links/app_links.dart' as _i327;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'app_router.dart' as _i313;
import 'core/database/app_database.dart' as _i111;
import 'core/network/api_client.dart' as _i871;
import 'core/network/connectivity_service.dart' as _i76;
import 'core/network/websocket_service.dart' as _i306;
import 'core/sync/sync_engine.dart' as _i572;
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
    as _i688;
import 'features/authentication/domain/use_cases/sign_in_usecase.dart' as _i925;
import 'features/authentication/domain/use_cases/sign_out_usecase.dart'
    as _i504;
import 'features/authentication/domain/use_cases/sign_up_usecase.dart' as _i907;
import 'features/authentication/domain/use_cases/verify_email_usecase.dart'
    as _i757;
import 'features/authentication/presentation/bloc/authentication_bloc.dart'
    as _i736;
import 'features/conversations/data/data_sources/conversations_local_data_source.dart'
    as _i260;
import 'features/conversations/data/data_sources/conversations_local_data_source_impl.dart'
    as _i1036;
import 'features/conversations/data/data_sources/conversations_remote_data_source.dart'
    as _i668;
import 'features/conversations/data/data_sources/conversations_remote_data_source_impl.dart'
    as _i103;
import 'features/conversations/data/repository/conversations_repository_impl.dart'
    as _i82;
import 'features/conversations/domain/repository/conversations_repository.dart'
    as _i150;
import 'features/conversations/domain/use_cases/create_group_chat_usecase.dart'
    as _i695;
import 'features/conversations/domain/use_cases/get_or_create_direct_chat_usecase.dart'
    as _i158;
import 'features/conversations/domain/use_cases/sync_chat_rooms_usecase.dart'
    as _i667;
import 'features/conversations/domain/use_cases/watch_chat_rooms_usecase.dart'
    as _i83;
import 'features/conversations/presentation/bloc/conversations_bloc.dart'
    as _i772;
import 'features/messaging/data/data_sources/messages_local_data_source.dart'
    as _i881;
import 'features/messaging/data/data_sources/messages_local_data_source_impl.dart'
    as _i747;
import 'features/messaging/data/data_sources/messages_remote_data_source.dart'
    as _i953;
import 'features/messaging/data/data_sources/messages_remote_data_source_impl.dart'
    as _i612;
import 'features/messaging/data/repository/messaging_repository_impl.dart'
    as _i503;
import 'features/messaging/domain/repository/messaging_repository.dart'
    as _i662;
import 'features/messaging/domain/use_cases/load_older_messages_usecase.dart'
    as _i852;
import 'features/messaging/domain/use_cases/mark_as_read_usecase.dart' as _i349;
import 'features/messaging/domain/use_cases/send_message_usecase.dart' as _i618;
import 'features/messaging/domain/use_cases/send_typing_usecase.dart' as _i581;
import 'features/messaging/domain/use_cases/watch_messages_usecase.dart'
    as _i364;
import 'features/messaging/domain/use_cases/watch_realtime_events_usecase.dart'
    as _i190;
import 'features/messaging/presentation/bloc/messaging_bloc.dart' as _i328;
import 'features/people/data/data_sources/people_local_data_source.dart'
    as _i316;
import 'features/people/data/data_sources/people_local_data_source_impl.dart'
    as _i502;
import 'features/people/data/data_sources/people_remote_data_source.dart'
    as _i348;
import 'features/people/data/data_sources/people_remote_data_source_impl.dart'
    as _i402;
import 'features/people/data/repository/people_repository_impl.dart' as _i387;
import 'features/people/domain/repository/people_repository.dart' as _i888;
import 'features/people/domain/use_cases/accept_connection_request_usecase.dart'
    as _i333;
import 'features/people/domain/use_cases/reject_connection_request_usecase.dart'
    as _i948;
import 'features/people/domain/use_cases/search_user_by_email_usecase.dart'
    as _i546;
import 'features/people/domain/use_cases/send_connection_request_usecase.dart'
    as _i877;
import 'features/people/domain/use_cases/sync_connections_usecase.dart'
    as _i764;
import 'features/people/domain/use_cases/watch_accepted_connections_usecase.dart'
    as _i117;
import 'features/people/domain/use_cases/watch_pending_requests_usecase.dart'
    as _i636;
import 'features/people/domain/use_cases/watch_sent_requests_usecase.dart'
    as _i33;
import 'features/people/presentation/bloc/people_bloc.dart' as _i192;
import 'features/search/data/data_sources/search_local_data_source.dart'
    as _i101;
import 'features/search/data/data_sources/search_local_data_source_impl.dart'
    as _i85;
import 'features/search/data/repositories/search_repository_impl.dart' as _i967;
import 'features/search/domain/repositories/search_repository.dart' as _i246;
import 'features/search/domain/usecases/global_search_usecase.dart' as _i177;
import 'features/search/presentation/bloc/search_bloc.dart' as _i944;
import 'features/settings/data/data_sources/settings_local_data_source.dart'
    as _i428;
import 'features/settings/data/data_sources/settings_local_data_source_impl.dart'
    as _i687;
import 'features/settings/data/data_sources/settings_remote_data_source.dart'
    as _i450;
import 'features/settings/data/data_sources/settings_remote_data_source_impl.dart'
    as _i363;
import 'features/settings/data/repositories/settings_repository_impl.dart'
    as _i113;
import 'features/settings/domain/repositories/settings_repository.dart'
    as _i309;
import 'features/settings/domain/usecases/clear_local_cache_usecase.dart'
    as _i1062;
import 'features/settings/domain/usecases/get_current_user_usecase.dart'
    as _i952;
import 'features/settings/domain/usecases/sign_out_usecase.dart' as _i400;
import 'features/settings/presentation/bloc/settings_bloc.dart' as _i421;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModules = _$RegisterModules();
    gh.lazySingleton<_i76.ConnectivityService>(
      () => _i76.ConnectivityService(),
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModules.firebaseAuth);
    gh.lazySingleton<_i327.AppLinks>(() => registerModules.appLinks);
    gh.lazySingleton<_i111.AppDatabase>(() => registerModules.appDatabase);
    gh.lazySingleton<_i361.Dio>(() => registerModules.dio);
    gh.lazySingleton<_i306.WebSocketService>(
      () => _i306.WebSocketService(
        gh<_i59.FirebaseAuth>(),
        gh<_i76.ConnectivityService>(),
      ),
    );
    gh.lazySingleton<_i101.SearchLocalDataSource>(
      () => _i85.SearchLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i450.SettingsRemoteDataSource>(
      () => _i363.SettingsRemoteDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i316.PeopleLocalDataSource>(
      () => _i502.PeopleLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i428.SettingsLocalDataSource>(
      () => _i687.SettingsLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i260.ConversationsLocalDataSource>(
      () => _i1036.ConversationsLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i373.AuthRemoteDataSource>(
      () => _i774.AuthRemoteDataSourceImpl(auth: gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i881.MessagesLocalDataSource>(
      () => _i747.MessagesLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i871.ApiClient>(
      () => _i871.ApiClient(gh<_i361.Dio>(), gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i938.AuthRepository>(
      () => _i910.AuthRepositoryImpl(
        remoteAuth: gh<_i373.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i246.SearchRepository>(
      () => _i967.SearchRepositoryImpl(gh<_i101.SearchLocalDataSource>()),
    );
    gh.lazySingleton<_i572.SyncEngine>(
      () => _i572.SyncEngine(
        gh<_i111.AppDatabase>(),
        gh<_i871.ApiClient>(),
        gh<_i306.WebSocketService>(),
        gh<_i76.ConnectivityService>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i309.SettingsRepository>(
      () => _i113.SettingsRepositoryImpl(
        gh<_i428.SettingsLocalDataSource>(),
        gh<_i450.SettingsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1062.ClearLocalCacheUsecase>(
      () => _i1062.ClearLocalCacheUsecase(gh<_i309.SettingsRepository>()),
    );
    gh.lazySingleton<_i952.GetCurrentUserUsecase>(
      () => _i952.GetCurrentUserUsecase(gh<_i309.SettingsRepository>()),
    );
    gh.lazySingleton<_i400.SignOutUsecase>(
      () => _i400.SignOutUsecase(gh<_i309.SettingsRepository>()),
    );
    gh.lazySingleton<_i348.PeopleRemoteDataSource>(
      () => _i402.PeopleRemoteDataSourceImpl(
        gh<_i871.ApiClient>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i733.CheckEmailVerificationUsecase>(
      () => _i733.CheckEmailVerificationUsecase(gh<_i938.AuthRepository>()),
    );
    gh.lazySingleton<_i492.ResetPaswordUsecase>(
      () => _i492.ResetPaswordUsecase(gh<_i938.AuthRepository>()),
    );
    gh.lazySingleton<_i688.SendResetPasswordEmailUsecase>(
      () => _i688.SendResetPasswordEmailUsecase(gh<_i938.AuthRepository>()),
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
    gh.lazySingleton<_i177.GlobalSearchUsecase>(
      () => _i177.GlobalSearchUsecase(gh<_i246.SearchRepository>()),
    );
    gh.lazySingleton<_i953.MessagesRemoteDataSource>(
      () => _i612.MessagesRemoteDataSourceImpl(
        gh<_i871.ApiClient>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.factory<_i944.SearchBloc>(
      () => _i944.SearchBloc(gh<_i177.GlobalSearchUsecase>()),
    );
    gh.lazySingleton<_i668.ConversationsRemoteDataSource>(
      () => _i103.ConversationsRemoteDataSourceImpl(
        gh<_i871.ApiClient>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i888.PeopleRepository>(
      () => _i387.PeopleRepositoryImpl(
        gh<_i348.PeopleRemoteDataSource>(),
        gh<_i316.PeopleLocalDataSource>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i150.ConversationsRepository>(
      () => _i82.ConversationsRepositoryImpl(
        gh<_i668.ConversationsRemoteDataSource>(),
        gh<_i260.ConversationsLocalDataSource>(),
      ),
    );
    gh.factory<_i421.SettingsBloc>(
      () => _i421.SettingsBloc(
        gh<_i952.GetCurrentUserUsecase>(),
        gh<_i1062.ClearLocalCacheUsecase>(),
        gh<_i400.SignOutUsecase>(),
      ),
    );
    gh.lazySingleton<_i736.AuthenticationBloc>(
      () => _i736.AuthenticationBloc(
        checkEmailVerification: gh<_i733.CheckEmailVerificationUsecase>(),
        verifyEmail: gh<_i757.VerifyEmailUsecase>(),
        sendResetPasswordEmailUsecase:
            gh<_i688.SendResetPasswordEmailUsecase>(),
        signOut: gh<_i504.SignOutUsecase>(),
        repository: gh<_i938.AuthRepository>(),
        resetPasword: gh<_i492.ResetPaswordUsecase>(),
        signIn: gh<_i925.SignInUsecase>(),
        signUp: gh<_i907.SignUpUsecase>(),
      ),
    );
    gh.lazySingleton<_i695.CreateGroupChatUsecase>(
      () => _i695.CreateGroupChatUsecase(gh<_i150.ConversationsRepository>()),
    );
    gh.lazySingleton<_i158.GetOrCreateDirectChatUsecase>(
      () => _i158.GetOrCreateDirectChatUsecase(
        gh<_i150.ConversationsRepository>(),
      ),
    );
    gh.lazySingleton<_i667.SyncChatRoomsUsecase>(
      () => _i667.SyncChatRoomsUsecase(gh<_i150.ConversationsRepository>()),
    );
    gh.lazySingleton<_i83.WatchChatRoomsUsecase>(
      () => _i83.WatchChatRoomsUsecase(gh<_i150.ConversationsRepository>()),
    );
    gh.lazySingleton<_i662.MessagingRepository>(
      () => _i503.MessagingRepositoryImpl(
        gh<_i953.MessagesRemoteDataSource>(),
        gh<_i881.MessagesLocalDataSource>(),
        gh<_i306.WebSocketService>(),
        gh<_i572.SyncEngine>(),
      ),
    );
    gh.lazySingleton<_i852.LoadOlderMessagesUsecase>(
      () => _i852.LoadOlderMessagesUsecase(gh<_i662.MessagingRepository>()),
    );
    gh.lazySingleton<_i349.MarkAsReadUsecase>(
      () => _i349.MarkAsReadUsecase(gh<_i662.MessagingRepository>()),
    );
    gh.lazySingleton<_i618.SendMessageUsecase>(
      () => _i618.SendMessageUsecase(gh<_i662.MessagingRepository>()),
    );
    gh.lazySingleton<_i581.SendTypingUsecase>(
      () => _i581.SendTypingUsecase(gh<_i662.MessagingRepository>()),
    );
    gh.lazySingleton<_i364.WatchMessagesUsecase>(
      () => _i364.WatchMessagesUsecase(gh<_i662.MessagingRepository>()),
    );
    gh.lazySingleton<_i190.WatchRealtimeEventsUsecase>(
      () => _i190.WatchRealtimeEventsUsecase(gh<_i662.MessagingRepository>()),
    );
    gh.lazySingleton<_i333.AcceptConnectionRequestUsecase>(
      () => _i333.AcceptConnectionRequestUsecase(gh<_i888.PeopleRepository>()),
    );
    gh.lazySingleton<_i948.RejectConnectionRequestUsecase>(
      () => _i948.RejectConnectionRequestUsecase(gh<_i888.PeopleRepository>()),
    );
    gh.lazySingleton<_i546.SearchUserByEmailUsecase>(
      () => _i546.SearchUserByEmailUsecase(gh<_i888.PeopleRepository>()),
    );
    gh.lazySingleton<_i877.SendConnectionRequestUsecase>(
      () => _i877.SendConnectionRequestUsecase(gh<_i888.PeopleRepository>()),
    );
    gh.lazySingleton<_i764.SyncConnectionsUsecase>(
      () => _i764.SyncConnectionsUsecase(gh<_i888.PeopleRepository>()),
    );
    gh.lazySingleton<_i117.WatchAcceptedConnectionsUsecase>(
      () => _i117.WatchAcceptedConnectionsUsecase(gh<_i888.PeopleRepository>()),
    );
    gh.lazySingleton<_i636.WatchPendingRequestsUsecase>(
      () => _i636.WatchPendingRequestsUsecase(gh<_i888.PeopleRepository>()),
    );
    gh.lazySingleton<_i33.WatchSentRequestsUsecase>(
      () => _i33.WatchSentRequestsUsecase(gh<_i888.PeopleRepository>()),
    );
    gh.factory<_i192.PeopleBloc>(
      () => _i192.PeopleBloc(
        gh<_i117.WatchAcceptedConnectionsUsecase>(),
        gh<_i636.WatchPendingRequestsUsecase>(),
        gh<_i33.WatchSentRequestsUsecase>(),
        gh<_i546.SearchUserByEmailUsecase>(),
        gh<_i877.SendConnectionRequestUsecase>(),
        gh<_i333.AcceptConnectionRequestUsecase>(),
        gh<_i948.RejectConnectionRequestUsecase>(),
        gh<_i764.SyncConnectionsUsecase>(),
      ),
    );
    gh.lazySingleton<_i313.AppRouter>(
      () => _i313.AppRouter(
        authBloc: gh<_i736.AuthenticationBloc>(),
        appLinks: gh<_i327.AppLinks>(),
      ),
    );
    gh.factory<_i328.MessagingBloc>(
      () => _i328.MessagingBloc(
        gh<_i364.WatchMessagesUsecase>(),
        gh<_i618.SendMessageUsecase>(),
        gh<_i852.LoadOlderMessagesUsecase>(),
        gh<_i349.MarkAsReadUsecase>(),
        gh<_i581.SendTypingUsecase>(),
        gh<_i190.WatchRealtimeEventsUsecase>(),
      ),
    );
    gh.factory<_i772.ConversationsBloc>(
      () => _i772.ConversationsBloc(
        gh<_i83.WatchChatRoomsUsecase>(),
        gh<_i158.GetOrCreateDirectChatUsecase>(),
        gh<_i695.CreateGroupChatUsecase>(),
        gh<_i667.SyncChatRoomsUsecase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModules extends _i864.RegisterModules {}
