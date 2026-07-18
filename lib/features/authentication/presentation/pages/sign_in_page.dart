import 'package:flutter/material.dart';
import 'package:fortress_chat/core/theme/app_elevation.dart';
import 'package:fortress_chat/core/theme/app_radii.dart';
import 'package:fortress_chat/core/theme/app_spacing.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/auth_textformfield.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/primary_button.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/validators.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      PrimaryButton(
                        onPressed: () {
                          _formState.currentState!.validate();
                        },
                        text: 'Sign In',
                        isLoading: false,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
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
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forgot password?',
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
        ],
      ),
    );
  }
}
