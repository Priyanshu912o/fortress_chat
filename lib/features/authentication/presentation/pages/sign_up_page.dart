import 'package:flutter/material.dart';
import 'package:temp/core/theme/app_elevation.dart';
import 'package:temp/core/theme/app_radii.dart';
import 'package:temp/core/theme/app_spacing.dart';
import 'package:temp/features/authentication/presentation/widgets/auth_textformfield.dart';
import 'package:temp/features/authentication/presentation/widgets/primary_button.dart';
import 'package:temp/features/authentication/presentation/widgets/signup_page_gradient.dart';
import 'package:temp/features/authentication/presentation/widgets/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ─── Decorative blurred circles area ───────────
        Expanded(flex: 1, child: CircleGradient()),
        // ─── Form area ─────────────────────────────────
        Expanded(
          flex: 2,

          child: Container(
            padding: const EdgeInsets.all(AppSpacing.marginDesktop),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadii.mediumValue),
                topRight: Radius.circular(AppRadii.mediumValue),
              ),
              boxShadow: AppElevation.shadowLarge,
            ),

            child: SingleChildScrollView(
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
                    ),

                    AuthTextFormField(
                      prefixIcon: Icons.mail_outline,
                      focusedPrefixIcon: Icons.mail,
                      hintText: 'you@example.com',
                      controller: _emailController,
                      validator: Validators.validator['email'],
                      lable: 'Rightful Email 😤',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    AuthTextFormField(
                      prefixIcon: Icons.key_outlined,
                      focusedPrefixIcon: Icons.key,
                      hintText: 'Create a strong password',
                      suffixIcon: Icon(Icons.visibility_off_outlined),
                      focusedSuffixIcon: Icon(Icons.visibility_off),
                      tappedSuffixIcon: Icon(Icons.visibility),
                      controller: _passwordController,
                      validator: Validators.validator['password'],
                      lable: 'Strong Password 💪',
                      helperText: 'Not 12345678 plss 🙏',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    AuthTextFormField(
                      prefixIcon: Icons.lock_reset,
                      focusedPrefixIcon: Icons.lock_reset_outlined,
                      hintText: 'How should we call you?',
                      controller: _confirmPasswordController,
                      validator: null,
                      lable: 'Confirm Password 👍',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.space16,
                      ),
                      child: PrimaryButton(
                        onPressed: () {
                          _formState.currentState!.validate();
                        },
                        text: 'Sign Up',
                        isLoading: false,
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
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
                          color: Theme.of(context).colorScheme.onInverseSurface,
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
        ),
      ],
    );
  }
}
