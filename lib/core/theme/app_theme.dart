import 'package:flutter/material.dart';
import 'package:fortress_chat/core/theme/app_elevation.dart';
import 'package:fortress_chat/core/theme/app_gradients.dart';
import 'package:fortress_chat/core/theme/app_radii.dart';
import 'package:fortress_chat/core/theme/app_typography.dart';
import 'package:fortress_chat/core/theme/colours_dark.dart';
import 'package:fortress_chat/core/theme/colours_light.dart';

final class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ColoursDark.background,
      colorScheme: ColorScheme(
        brightness: ColoursDark.brightness,
        primary: ColoursDark.primary,
        primaryContainer: ColoursDark.primaryVariant,
        onPrimary: ColoursDark.onPrimary,
        secondary: ColoursDark.secondary,
        secondaryContainer: ColoursDark.secondaryVariant,
        onSecondary: ColoursDark.onSecondary,
        tertiary: ColoursDark.tertiary,
        onTertiary: ColoursDark.onTertiary,
        error: ColoursDark.error,
        onError: ColoursDark.onError,
        surface: ColoursDark.surface,
        surfaceContainer: ColoursDark.surfaceVariant,
        onSurface: ColoursDark.onSurface,
        onInverseSurface: ColoursLight.onSurfaceMuted,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppElevation.small,
          shape: RoundedRectangleBorder(borderRadius: AppRadii.small),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: AppElevation.medium,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.medium),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: AppRadii.small),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppRadii.small),
      ),
      appBarTheme: AppBarTheme(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppGradients.appBar,
            boxShadow: AppElevation.shadowSmall,
          ),
        ),
      ),
      textTheme: AppTypography.textTheme(color: ColoursLight.background),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ColoursLight.background,
      colorScheme: ColorScheme(
        brightness: ColoursLight.brightness,
        primary: ColoursLight.primary,
        primaryContainer: ColoursLight.primaryVariant,
        onPrimary: ColoursLight.onPrimary,
        secondary: ColoursLight.secondary,
        secondaryContainer: ColoursLight.secondaryVariant,
        onSecondary: ColoursLight.onSecondary,
        tertiary: ColoursLight.tertiary,
        onTertiary: ColoursLight.onTertiary,
        error: ColoursLight.error,
        onError: ColoursLight.onError,
        surface: ColoursLight.surface,
        surfaceContainer: ColoursLight.surfaceVariant,
        onSurface: ColoursLight.onSurface,
        onInverseSurface: ColoursLight.onSurfaceMuted,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppElevation.small,
          shape: RoundedRectangleBorder(borderRadius: AppRadii.small),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: AppElevation.medium,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.medium),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: AppRadii.small),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppRadii.small),
      ),
      appBarTheme: AppBarTheme(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppGradients.appBarDark,
            boxShadow: AppElevation.shadowSmall,
          ),
        ),
      ),
      textTheme: AppTypography.textTheme(color: ColoursDark.background),
    );
  }
}
