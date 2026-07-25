import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortress_chat/core/components/routes.dart';
import 'package:fortress_chat/core/theme/app_elevation.dart';
import 'package:fortress_chat/core/theme/app_radii.dart';
import 'package:fortress_chat/core/theme/app_spacing.dart';
import 'package:fortress_chat/features/authentication/presentation/blocs/signin_bloc/auth_signin_bloc.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/auth_textformfield.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/primary_button.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/validators.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<AuthSignInBloc>(),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TapGestureRecognizer _onTap1;
  late final TapGestureRecognizer _onTap2;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _onTap1 = TapGestureRecognizer()
      ..onTap = () {
        context.goNamed(Routes.signUp.toString());
      };
    _onTap2 = TapGestureRecognizer()
      ..onTap = () {
        context.goNamed(Routes.forgotPassword.toString());
      };
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _onTap1.dispose();
    _onTap2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthSignInBloc, AuthSignInState>(
        listener: (context, state) {
          if (state is AuthSignInFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: AppElevation.small,
                padding: const EdgeInsets.all(AppSpacing.space4),
                duration: const Duration(seconds: 10),
                content: Container(
                  padding: const EdgeInsets.all(AppSpacing.space2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  child: Text(state.failure.message),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(AppSpacing.marginDesktop),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space32),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSpacing.space32,
                  bottom: AppSpacing.space16,
                ),
                child: Icon(
                  Icons.shield_outlined,
                  size:
                      Theme.of(context).textTheme.headlineLarge!.fontSize! * 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.space2,
                ),
                child: Text(
                  'Secure your communications',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    wordSpacing: AppSpacing.space2,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.marginMobile,
                  vertical: AppSpacing.space32,
                ),
                padding: const EdgeInsets.all(AppSpacing.space24),
                decoration: BoxDecoration(
                  boxShadow: AppElevation.shadowMedium,
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppRadii.xLarge,
                ),
                child: Form(
                  key: _formState,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: AppSpacing.space24,
                    children: [
                      AuthTextFormField(
                        focusedPrefixIcon: Icons.email,
                        hintText: 'name@example.com',
                        prefixIcon: Icons.email_outlined,
                        controller: _emailController,
                        lable: 'Email address',
                        validator: Validators.validator['email'],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      AuthTextFormField(
                        focusedPrefixIcon: Icons.lock,
                        hintText: 'name@example.com',
                        prefixIcon: Icons.lock_outline,
                        controller: _passwordController,
                        lable: 'Password',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: Validators.validator['password'],
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: const Icon(Icons.visibility_off_outlined),
                        focusedSuffixIcon: const Icon(Icons.visibility_off),
                        tappedSuffixIcon: const Icon(Icons.visibility),
                        isObscure: true,
                      ),
                      BlocBuilder<AuthSignInBloc, AuthSignInState>(
                        builder: (context, state) {
                          return PrimaryButton(
                            onPressed: () {
                              if (_formState.currentState!.validate()) {
                                context.read<AuthSignInBloc>().add(
                                  AuthSigningInEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              }
                            },
                            text: 'Sign In',
                            isLoading: state is AuthSignInLoadingState,
                          );
                        },
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              recognizer: _onTap1,
                              text: 'Sign Up',
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          recognizer: _onTap2,
                          text: 'Forgot password?',
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onInverseSurface,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
