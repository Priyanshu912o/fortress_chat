import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Fortress/core/components/routes.dart';
import 'package:Fortress/core/theme/app_elevation.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/app_spacing.dart';
import 'package:Fortress/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:Fortress/features/authentication/presentation/widgets/primary_button.dart';
import 'package:go_router/go_router.dart';

class NewPasswordsetPage extends StatefulWidget {
  const NewPasswordsetPage({super.key});

  @override
  State<NewPasswordsetPage> createState() => _NewPasswordsetPageState();
}

class _NewPasswordsetPageState extends State<NewPasswordsetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSpacing.space24,
        children: [
          //place an icon here
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
                  'Password Reset',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Your digital sanctuary is secure. \n Your password has been \n successfully updated.',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),

                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      onPressed: () {
                        context.goNamed(Routes.signIn.toString());
                      },
                      text: 'Sign In to Fortress',
                      isLoading: state is LoadingState,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
