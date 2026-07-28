import 'package:app_links/app_links.dart';
import 'package:fortress_chat/core/components/routes.dart';
import 'package:fortress_chat/core/utils/stream_to_listenable.dart';
import 'package:fortress_chat/core/widgets/splash.dart';
import 'package:fortress_chat/features/Chats/presentation/pages/all_chats.dart';
import 'package:fortress_chat/features/authentication/presentation/blocs/global_auth_bloc/authentication_bloc.dart';
import 'package:fortress_chat/features/authentication/presentation/pages/email_sent_page.dart';
import 'package:fortress_chat/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:fortress_chat/features/authentication/presentation/pages/password_reset_page.dart';
import 'package:fortress_chat/features/authentication/presentation/pages/reset_password_page.dart';
import 'package:fortress_chat/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:fortress_chat/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppRouter {
  final AuthenticationBloc authBloc;
  final AppLinks appLinks;

  AppRouter({required this.authBloc, required this.appLinks}) {
    void handleLinks(Uri uri) {
      String? innerLink = uri.queryParameters['link'];

      Uri actionUri;
      if (innerLink != null) {
        actionUri = Uri.parse(innerLink);
      } else {
        actionUri = uri;
      }

      final String? oobCode = actionUri.queryParameters['oobCode'];
      final String mode = actionUri.queryParameters['mode'] ?? '';
      if (mode == 'resetPassword' && oobCode != null) {
        appRouter.go(
          '/resetpassword?oobCode=$oobCode',
        );
      }
    }

    appLinks.uriLinkStream.listen((uri) {
      handleLinks(uri);
    });

    appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        handleLinks(uri);
      }
    });
  }

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
      GoRoute(
        name: Routes.passwordreset.toString(),
        path: '/passwordreset',
        builder: (context, state) => const PasswordResetPage(),
      ),
      GoRoute(
        name: Routes.emailsent.toString(),
        path: '/emailsent',
        builder: (context, state) => const EmailSentPage(),
      ),
      GoRoute(
        name: Routes.resetPassword.toString(),
        path: '/resetpassword',
        builder: (context, state) {
          final oobCode = state.uri.queryParameters['oobCode'];
          return ResetPasswordPage(oobCode: oobCode ?? '');
        },
      ),
    ],
    refreshListenable: StreamToListenable(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final signingIn = state.matchedLocation == '/signin';
      final signingUp = state.matchedLocation == '/signup';
      final forgotPassword = state.matchedLocation == '/forgotpassword';
      final resetPassword = state.matchedLocation == '/resetpassword';
      final paswordReset = state.matchedLocation == '/paswordreset';
      final emailSent = state.matchedLocation == '/emailsent';
      final splash = state.matchedLocation == '/splash';

      if (authState is AuthInitialState) {
        return (splash || resetPassword) ? null : '/splash';
      }
      if (authState is UnAuthenticatedState) {
        return (signingUp ||
                forgotPassword ||
                resetPassword ||
                paswordReset ||
                emailSent)
            ? null
            : '/signin';
      }
      if (authState is AuthenticatedState) {
        return (signingIn || splash || signingUp) ? '/home' : null;
      }

      return null;
    },
  );
}
