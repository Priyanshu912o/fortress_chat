import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fortress_chat/core/theme/app_elevation.dart';
import 'package:fortress_chat/core/theme/app_radii.dart';
import 'package:fortress_chat/core/theme/app_spacing.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/auth_textformfield.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/primary_button.dart';
import 'package:fortress_chat/features/authentication/presentation/widgets/validators.dart';

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
      body: ListView(
        children: [
          Container(
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
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 6),
                        child: Container(
                          height: 7,
                          margin: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.space32,
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

                PrimaryButton(
                  onPressed: () {},
                  text: 'Send Reset Link',
                  isLoading: false,
                ),
                TextButton(
                  onPressed: () {},
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
        ],
      ),
    );
  }
}
