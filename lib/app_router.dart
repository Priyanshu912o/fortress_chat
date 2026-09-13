import 'package:Fortress/core/components/routes.dart';
import 'package:Fortress/core/utils/stream_to_listenable.dart';
import 'package:Fortress/core/widgets/loading_page.dart';
import 'package:Fortress/core/widgets/scaffold_with_navbar.dart';
import 'package:Fortress/core/widgets/splash.dart';
import 'package:Fortress/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:Fortress/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:Fortress/features/authentication/presentation/pages/password_reset_email_sent_page.dart';
import 'package:Fortress/features/authentication/presentation/pages/password_reset_page.dart';
import 'package:Fortress/features/authentication/presentation/pages/reset_password_page.dart';
import 'package:Fortress/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:Fortress/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:Fortress/features/authentication/presentation/pages/verify_email_page.dart';
import 'package:Fortress/features/conversations/presentation/pages/chats.dart';
import 'package:Fortress/features/messaging/presentation/pages/messages_page.dart';
import 'package:Fortress/features/people/presentation/pages/people.dart';
import 'package:Fortress/features/search/presentation/pages/search_page.dart';
import 'package:Fortress/features/settings/presentation/pages/settings_page.dart';
import 'package:app_links/app_links.dart';
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
        appRouter.go('/resetpassword?oobCode=$oobCode');
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
    initialLocation: '/loading',

    routes: [
      GoRoute(
        name: Routes.loading.toString(),
        path: '/loading',
        builder: (context, state) => const LoadingPage(),
      ),
      GoRoute(
        name: Routes.splash.toString(),
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavbar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.home.toString(),
                path: '/home',
                builder: (context, state) => const ChatsPage(),
                routes: [
                  GoRoute(
                    name: Routes.chat.toString(),
                    path: 'chat/:chatRoomId',
                    builder: (context, state) {
                      final chatRoomId = state.pathParameters['chatRoomId'] ?? '';
                      final chatRoomName = state.extra as String?;
                      return MessagesPage(
                        chatRoomId: chatRoomId,
                        chatRoomName: chatRoomName,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.people.toString(),
                path: '/people',
                builder: (context, state) => const PeoplePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.search.toString(),
                path: '/search',
                builder: (context, state) => const SearchPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.settings.toString(),
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: Routes.signIn.toString(),
        path: '/signin',
        builder: (context, state) => const SignInPage(),
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
        name: Routes.newpasswordset.toString(),
        path: '/passwordset',
        builder: (context, state) => const NewPasswordsetPage(),
      ),
      GoRoute(
        name: Routes.resetpasswordemailsent.toString(),
        path: '/resetpasswordemailsent',
        builder: (context, state) => const PasswordResetEmailSentPage(),
      ),
      GoRoute(
        name: Routes.verifyemailsent.toString(),
        path: '/verifyemail',
        builder: (context, state) => const VerifyEmailPage(),
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
      final loading = state.matchedLocation == '/loading';
      final signingUp = state.matchedLocation == '/signup';
      final forgotPassword = state.matchedLocation == '/forgotpassword';
      final resetPassword = state.matchedLocation == '/resetpassword';
      final newPasswordSet = state.matchedLocation == '/passwordset';
      final verifyEmail = state.matchedLocation == '/verifyemail';
      final resetPasswordEmailSent =
          state.matchedLocation == '/resetpasswordemailsent';

      if (authState is AuthInitialState) {
        return (loading || resetPassword) ? null : '/loading';
      }
      if (authState is UnAuthenticatedState) {
        return (signingUp ||
                signingIn ||
                forgotPassword ||
                resetPasswordEmailSent ||
                resetPassword ||
                newPasswordSet)
            ? null
            : '/signin';
      }
      if (authState is AuthenticatedState) {
        final isEmailVerified = authState.user.isEmailVerified;
        if (isEmailVerified) {
          return (signingUp ||
                  signingIn ||
                  forgotPassword ||
                  resetPasswordEmailSent ||
                  resetPassword ||
                  newPasswordSet ||
                  loading ||
                  verifyEmail)
              ? '/home'
              : null;
        } else {
          return verifyEmail ? null : '/verifyemail';
        }
      }
      return null;
    },
  );
}
