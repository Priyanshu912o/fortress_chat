import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Fortress/app_router.dart';
import 'package:Fortress/core/network/api_client.dart';
import 'package:Fortress/core/network/websocket_service.dart';
import 'package:Fortress/core/sync/sync_engine.dart';
import 'package:Fortress/core/theme/app_theme.dart';
import 'package:Fortress/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:Fortress/firebase_options.dart';
import 'package:Fortress/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'core/network/network_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NetworkConfig.resolveHost();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();

  // Initialize core background services
  getIt<SyncEngine>();
  final wsService = getIt<WebSocketService>();
  final apiClient = getIt<ApiClient>();

  // Synchronize user profile with backend on auth changes
  FirebaseAuth.instance.authStateChanges().listen((user) async {
    if (user != null) {
      try {
        await apiClient.post(
          '/api/users/sync',
          data: {
            'name': user.displayName ?? user.email?.split('@')[0] ?? 'User',
            'dpUrl': user.photoURL,
          },
        );
        wsService.connect();
      } catch (_) {
        // Handled silently
      }
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = GetIt.instance<AuthenticationBloc>();
    final GoRouter router = GetIt.instance<AppRouter>().appRouter;

    return BlocProvider.value(
      value: authBloc,
      child: MaterialApp.router(
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.system,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Fortress',
      ),
    );
  }
}