import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortress_chat/app_router.dart';
import 'package:fortress_chat/core/theme/app_theme.dart';
import 'package:fortress_chat/features/authentication/presentation/blocs/global_auth_bloc/authentication_bloc.dart';
import 'package:fortress_chat/firebase_options.dart';
import 'package:fortress_chat/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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