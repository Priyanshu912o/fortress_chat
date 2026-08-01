import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Fortress/core/components/routes.dart';
import 'package:Fortress/core/theme/app_elevation.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:Fortress/features/authentication/presentation/widgets/auth_textformfield.dart';
import 'package:Fortress/features/authentication/presentation/widgets/primary_button.dart';
import 'package:Fortress/features/authentication/presentation/widgets/validators.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatefulWidget {
  final String oobCode;
  const ResetPasswordPage({super.key, required this.oobCode});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          } else if (state is NewPasswordSetState) {
            context.goNamed(Routes.newpasswordset.toString());
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space48),
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppSpacing.space24,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    MediaQuery.platformBrightnessOf(context) == Brightness.light
                        ? 'assets/icon/logo_light.png'
                        : 'assets/icon/logo_dark.png',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(AppSpacing.marginMobile),
                  padding: const EdgeInsets.all(AppSpacing.space24),
                  decoration: BoxDecoration(
                    boxShadow: AppElevation.shadowMedium,
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: AppRadii.xLarge,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: AppSpacing.space32,
                    children: [
                      Text(
                        'New Password',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'Create a strong, unique password to \n secure your digital sanctuary.',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AuthTextFormField(
                        prefixIcon: Icons.key_outlined,
                        focusedPrefixIcon: Icons.key,
                        hintText: 'Create a strong password',
                        controller: _passwordController,
                        lable: 'New Password 💪',
                        helperText: 'Not 12345678 plss 🙏',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: Validators.validator['password'],
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: const Icon(Icons.visibility_off_outlined),
                        focusedSuffixIcon: const Icon(Icons.visibility_off),
                        tappedSuffixIcon: const Icon(Icons.visibility),
                        isObscure: true,
                      ),

                      AuthTextFormField(
                        prefixIcon: Icons.lock_reset,
                        focusedPrefixIcon: Icons.lock_reset_outlined,
                        hintText: 'How should we call you?',
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Re-enter your password';
                          }
                          if (_passwordController.text != value) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                        lable: 'Confirm New Password 👍',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: const Icon(Icons.visibility_off_outlined),
                        focusedSuffixIcon: const Icon(Icons.visibility_off),
                        tappedSuffixIcon: const Icon(Icons.visibility),
                        isObscure: true,
                      ),

                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          return PrimaryButton(
                            onPressed: () {
                              if (_globalKey.currentState?.validate() ??
                                  false) {
                                context.read<AuthenticationBloc>().add(
                                  ResetPasswordEvent(
                                    newPassword: _passwordController.text,
                                    oobCode: widget.oobCode,
                                  ),
                                );
                              }
                            },
                            text: 'Reset Password',
                            isLoading: state is LoadingState,
                          );
                        },
                      ),
                    ],
                  ),
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
