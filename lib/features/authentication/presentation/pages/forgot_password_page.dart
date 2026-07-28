import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortress_chat/core/components/routes.dart';
import 'package:fortress_chat/core/theme/app_elevation.dart';
import 'package:fortress_chat/core/theme/app_radii.dart';
import 'package:fortress_chat/core/theme/app_spacing.dart';
import 'package:fortress_chat/features/authentication/presentation/blocs/global_auth_bloc/authentication_bloc.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/auth_textformfield.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/primary_button.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/validators.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final TextEditingController _emailController;
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
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
          }else if(state is EmailSentState){
            context.goNamed(Routes.emailsent.toString());
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space48),
          child: Container(
            margin: const EdgeInsets.all(AppSpacing.marginMobile),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space24),
            decoration: BoxDecoration(
              boxShadow: AppElevation.shadowMedium,
              color: Theme.of(context).colorScheme.surface,
              borderRadius: AppRadii.xLarge,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppSpacing.space24,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 7,
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space32,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(AppRadii.xLargeValue),
                          bottomRight: Radius.circular(AppRadii.xLargeValue),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 6),
                        child: Container(
                          height: 12,
                          margin: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.space24,
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),

                CircleAvatar(
                  radius: Theme.of(context).textTheme.headlineLarge!.fontSize,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.onInverseSurface.withValues(alpha: 0.2),
                  child: Icon(
                    Icons.lock_reset_rounded,
                    size:
                        Theme.of(context).textTheme.headlineLarge!.fontSize! *
                        1.2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  'Reset Password',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Enter your email address and we\'ll send you a link to reset your password',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
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

                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      onPressed: () {
                        if (_emailController.text.isNotEmpty) {
                          context.read<AuthenticationBloc>().add(
                            SendResetPasswordEmailEvent(
                              email: _emailController.text,
                            ),
                          );
                        }
                      },
                      text: 'Send Reset Link',
                      isLoading: state is LoadingState,
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    context.goNamed(Routes.signIn.toString());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      Text(' back to Sign In'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
