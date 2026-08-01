import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:Fortress/features/authentication/presentation/widgets/primary_button.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late final TapGestureRecognizer _onTap;

  @override
  void initState() {
    _onTap = TapGestureRecognizer()
      ..onTap = () {
        context.read<AuthenticationBloc>().add(ResendVerifyEmail());
      };
    super.initState();
  }

  @override
  void dispose() {
    _onTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fortress',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(AppSpacing.marginMobile),
        child: Column(
          spacing: AppSpacing.space12,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
              child: CircleAvatar(
                radius:
                    Theme.of(context).textTheme.headlineLarge!.fontSize! * 2,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withAlpha(30),
                child: Icon(
                  Icons.mail,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  size:
                      Theme.of(context).textTheme.headlineLarge!.fontSize! * 2,
                ),
              ),
            ),
            Text(
              'Verify your email',
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            RichText(
              text: TextSpan(
                text: 'Didn\'t recieve the mail? ',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
                children: [
                  TextSpan(
                    recognizer: _onTap,
                    text: 'Resend mail',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  size: Theme.of(context).textTheme.labelLarge!.fontSize! * 1.2,
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(SignOutEvent());
                  },
                  child: Text(
                    'Back to login',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                ),
              ],
            ),
            PrimaryButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(
                  CheckEmailVerificationEvent(),
                );
              },
              text: 'Check verification',
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }
}
