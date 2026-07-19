import 'package:flutter/material.dart';
import 'package:fortress_chat/core/theme/colours_dark.dart';
import 'package:fortress_chat/core/theme/colours_light.dart';

/// Fortress Gradient Tokens
/// All gradients use subtle, smooth 2–3 stop transitions.
abstract final class AppGradients {
  // ── Light Mode Gradients ──────────────────────────────────────────────────

  /// 135°, primary → primaryLight — Sent chat bubbles, primary buttons
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
  );

  /// 180°, surface → surface @ 95% — App bar with subtle fade
  static const LinearGradient appBar = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ColoursLight.surface,
      Color(0xF2FFFFFF), // surface @ 95% opacity
    ],
  );

  /// 135°, primary @ 5% → secondary @ 5% — Faint tint behind security badges
  static const LinearGradient securityBanner = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x0D6C5CE7), // primary @ 5%
      Color(0x0D00CEC9), // secondary @ 5%
    ],
  );

  // ── Dark Mode Gradients ───────────────────────────────────────────────────

  /// 135°, primaryVariant (dark) → primaryDark — Dark mode sent bubbles
  static const LinearGradient primaryDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5A4BD1), Color(0xFF8B7FF0)],
  );

  /// Dark mode app bar — subtle surface fade
  static const LinearGradient appBarDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ColoursDark.surface,
      Color(0xF2161B22), // dark surface @ 95% opacity
    ],
  );

  /// Dark mode security banner — same hues, adjusted for dark bg
  static const LinearGradient securityBannerDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x0DA29BFE), // primary dark @ 5%
      Color(0x0D55EFC4), // secondary dark @ 5%
    ],
  );
}
