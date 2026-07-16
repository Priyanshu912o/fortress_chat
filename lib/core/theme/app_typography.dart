import 'package:flutter/material.dart';

/// Fortress Typography System
/// Font: Inter (fallback: Outfit)
/// Register 'Inter' in pubspec.yaml under fonts, or use google_fonts package.
abstract final class AppTypography {
  static const String _fontFamily = 'Inter';

  /// 32sp, Bold (700), -0.5px — Splash title
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  /// 28sp, Bold (700), -0.25px — Page titles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );

  /// 22sp, SemiBold (600), 0 — Section headers
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  /// 18sp, SemiBold (600), 0.15px — Chat contact name
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  /// 16sp, Medium (500), 0.15px — Subheads, dialog titles
  static const TextStyle titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  /// 16sp, Regular (400), 0.5px — Chat messages, body text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  /// 14sp, Regular (400), 0.25px — Secondary info, descriptions
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  /// 12sp, Regular (400), 0.4px — Timestamps, captions
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  /// 14sp, SemiBold (600), 1.0px — Button text
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );

  /// 10sp, Medium (500), 1.5px — Overlines, badges
  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );

  /// Builds a complete [TextTheme] for use in [ThemeData].
  /// Call with the appropriate [color] for light/dark mode.
  static TextTheme textTheme({required Color color}) {
    return TextTheme(
      displayLarge: displayLarge.copyWith(color: color),
      headlineLarge: headlineLarge.copyWith(color: color),
      headlineMedium: headlineMedium.copyWith(color: color),
      titleLarge: titleLarge.copyWith(color: color),
      titleMedium: titleMedium.copyWith(color: color),
      bodyLarge: bodyLarge.copyWith(color: color),
      bodyMedium: bodyMedium.copyWith(color: color),
      bodySmall: bodySmall.copyWith(color: color),
      labelLarge: labelLarge.copyWith(color: color),
      labelSmall: labelSmall.copyWith(color: color),
    );
  }
}
