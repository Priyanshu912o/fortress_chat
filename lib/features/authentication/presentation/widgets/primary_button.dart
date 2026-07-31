import 'package:flutter/material.dart';
import 'package:Fortress/core/theme/app_gradients.dart';
import 'package:Fortress/core/theme/app_radii.dart';
import 'package:Fortress/core/theme/app_spacing.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _text;
  final bool _isLoading;
  const PrimaryButton({
    super.key,
    required this._onPressed,
    required this._text,
    required this._isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: MediaQuery.platformBrightnessOf(context) == Brightness.dark
            ? AppGradients.primaryDark
            : AppGradients.primary,
        borderRadius: AppRadii.medium,
      ),
      child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: Colors.transparent),
        onPressed: _onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _text,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              _isLoading
                  ? SizedBox.square(
                      dimension:
                          (Theme.of(context).textTheme.labelLarge?.fontSize ??
                              14) *
                          2,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.all(AppSpacing.space8),
                        strokeWidth: 2,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.space8,
                      ),
                      child: Icon(Icons.arrow_forward),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
