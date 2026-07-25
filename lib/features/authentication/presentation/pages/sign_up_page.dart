import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortress_chat/core/components/routes.dart';
import 'package:fortress_chat/core/theme/app_elevation.dart';
import 'package:fortress_chat/core/theme/app_radii.dart';
import 'package:fortress_chat/core/theme/app_spacing.dart';
import 'package:fortress_chat/features/authentication/presentation/blocs/signup_bloc/auth_signup_bloc.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/auth_textformfield.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/circle_gradient.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/primary_button.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/validators.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<AuthSignUpBloc>(),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TapGestureRecognizer _onTap;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _onTap = TapGestureRecognizer()
      ..onTap = () {
        context.goNamed(Routes.signIn.toString());
      };
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _onTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                // ─── Decorative blurred circles area ───────────
                const Expanded(flex: 1, child: CircleGradient()),
                // ─── Form area ─────────────────────────────────
                Expanded(
                  flex: 2,

                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.marginDesktop),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppRadii.xLargeValue),
                        topRight: Radius.circular(AppRadii.xLargeValue),
                      ),
                      boxShadow: AppElevation.shadowLarge,
                    ),

                    child: Form(
                      key: _formState,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AuthTextFormField(
                            prefixIcon: Icons.person_outline,
                            focusedPrefixIcon: Icons.person,
                            hintText: 'How should we call you?',
                            controller: _nameController,
                            validator: Validators.validator['name'],
                            lable: 'Lovely Name 🫶',
                            keyboardType: TextInputType.name,
                          ),

                          AuthTextFormField(
                            prefixIcon: Icons.mail_outline,
                            focusedPrefixIcon: Icons.mail,
                            hintText: 'you@example.com',
                            controller: _emailController,
                            lable: 'Rightful Email 😤',
                            validator: Validators.validator['email'],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          AuthTextFormField(
                            prefixIcon: Icons.key_outlined,
                            focusedPrefixIcon: Icons.key,
                            hintText: 'Create a strong password',
                            controller: _passwordController,
                            lable: 'Strong Password 💪',
                            helperText: 'Not 12345678 plss 🙏',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: Validators.validator['password'],
                            keyboardType: TextInputType.visiblePassword,
                            suffixIcon: const Icon(
                              Icons.visibility_off_outlined,
                            ),
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
                            lable: 'Confirm Password 👍',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.visiblePassword,
                            suffixIcon: const Icon(
                              Icons.visibility_off_outlined,
                            ),
                            focusedSuffixIcon: const Icon(Icons.visibility_off),
                            tappedSuffixIcon: const Icon(Icons.visibility),
                            isObscure: true,
                          ),

                          BlocBuilder<AuthSignUpBloc, AuthSignUpState>(
                            builder: (context, state) {
                              return PrimaryButton(
                                onPressed: () {
                                  if (_formState.currentState!.validate()) {
                                    context.read<AuthSignUpBloc>().add(
                                      AuthSigningUpEvent(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  }
                                },
                                text: 'Sign Up',
                                isLoading: state is AuthSignUpLoadingState,
                              );
                            },
                          ),

                          RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                  recognizer: _onTap,
                                  text: 'Sign In',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock,
                                size: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.fontSize,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onInverseSurface,
                              ),
                              Text(
                                '  ENCYPTED LOCALLY',
                                style: Theme.of(context).textTheme.labelMedium!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onInverseSurface,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
