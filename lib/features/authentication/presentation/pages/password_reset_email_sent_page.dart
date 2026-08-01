import 'package:flutter/material.dart';
import 'package:Fortress/core/components/routes.dart';
import 'package:Fortress/core/theme/app_elevation.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

class PasswordResetEmailSentPage extends StatefulWidget {
  const PasswordResetEmailSentPage({super.key});

  @override
  State<PasswordResetEmailSentPage> createState() =>
      _PasswordResetEmailSentPageState();
}

class _PasswordResetEmailSentPageState
    extends State<PasswordResetEmailSentPage> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSpacing.space24,
        children: [
          // plaace an icon here
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
                  'Link Sent',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'We\'ve sent a secure recovery link \n to your email address. Please check \n your inbox to continue.',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
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
              children: [Icon(Icons.arrow_back), Text(' back to Sign In')],
            ),
          ),

          Text(
            'Link expires in 15 minutes',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
          ),
        ],
      ),
    );
  }
}
