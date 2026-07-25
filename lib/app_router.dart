import 'package:fortress_chat/core/components/routes.dart';
import 'package:fortress_chat/core/utils/stream_to_listenable.dart';
import 'package:fortress_chat/core/widgets/splash.dart';
import 'package:fortress_chat/features/Chats/presentation/pages/all_chats.dart';
import 'package:fortress_chat/features/authentication/presentation/blocs/global_auth_bloc/authentication_bloc.dart';
import 'package:fortress_chat/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:fortress_chat/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:fortress_chat/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppRouter {
  final AuthenticationBloc authBloc = GetIt.instance<AuthenticationBloc>();
  late final GoRouter appRouter = GoRouter(
    initialLocation: '/splash',

    routes: [
      GoRoute(
        name: Routes.splash.toString(),
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: Routes.signIn.toString(),
        path: '/signin',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: Routes.home.toString(),
        path: '/home',
        builder: (context, state) => const AllChats(),
      ),
      GoRoute(
        name: Routes.signUp.toString(),
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        name: Routes.forgotPassword.toString(),
        path: '/forgotpassword',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
    ],
    refreshListenable: StreamToListenable(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final signingIn = state.matchedLocation == '/signin';
      final signingUp = state.matchedLocation == '/signup';
      final forgotPassword = state.matchedLocation == '/forgotpassword';
      final splash = state.matchedLocation == '/splash';

      if (authState is AuthInitialState) {
        return splash ? null : '/splash';
      }
      if (authState is UnAuthenticatedState) {
        return (signingUp || forgotPassword) ? null : '/signin';
      }
      if (authState is AuthenticatedState) {
        return (signingIn || splash || signingUp || forgotPassword)
            ? '/home'
            : null;
      }

      return null;
    },
  );
}
