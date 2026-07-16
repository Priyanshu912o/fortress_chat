import 'package:flutter/material.dart';

/// Fortress Elevation & Shadow Tokens
/// Use [BoxShadow] lists for containers/cards, and [elevation] values
/// for Material widgets that accept an elevation parameter.
abstract final class AppElevation {
  // ── Material Elevation Values ─────────────────────────────────────────────

  static const double small = 1;       // Cards at rest
  static const double medium = 4;      // Elevated cards, FAB
  static const double large = 8;       // Modals, bottom sheets

  // ── BoxShadow Definitions ─────────────────────────────────────────────────
  // Use these with Container/DecoratedBox when you need custom shadow control.
  // Each shadow uses two layers: key (directional) + ambient (diffuse).

  /// Cards at rest
  static const List<BoxShadow> shadowSmall = [
    // Key shadow — sharp, directional (light from above)
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      color: Color(0x1A000000), // ~10% black
    ),
    // Ambient shadow — soft, all-around depth
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 5,
      spreadRadius: 1,
      color: Color(0x0D000000), // ~5% black
    ),
  ];

  /// Elevated cards, FAB
  static const List<BoxShadow> shadowMedium = [
    // Key shadow
    BoxShadow(
      offset: Offset(0, 3),
      blurRadius: 6,
      color: Color(0x26000000), // ~15% black
    ),
    // Ambient shadow
    BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 16,
      spreadRadius: 2,
      color: Color(0x0F000000), // ~6% black
    ),
  ];

  /// Modals, bottom sheets
  static const List<BoxShadow> shadowLarge = [
    // Key shadow
    BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 12,
      color: Color(0x29000000), // ~16% black
    ),
    // Ambient shadow
    BoxShadow(
      offset: Offset(0, 12),
      blurRadius: 32,
      spreadRadius: 4,
      color: Color(0x12000000), // ~7% black
    ),
  ];

  /// Focused input fields — light mode (purple glow)
  static const List<BoxShadow> shadowGlowLight = [
    // Inner glow ring — tighter, more vivid
    BoxShadow(
      offset: Offset.zero,
      blurRadius: 8,
      color: Color(0x406C5CE7), // primary @ 25%
    ),
    // Outer glow — softer, wider spread
    BoxShadow(
      offset: Offset.zero,
      blurRadius: 20,
      spreadRadius: 2,
      color: Color(0x1A6C5CE7), // primary @ 10%
    ),
  ];

  /// Focused input fields — dark mode (lighter purple glow)
  static const List<BoxShadow> shadowGlowDark = [
    // Inner glow ring
    BoxShadow(
      offset: Offset.zero,
      blurRadius: 8,
      color: Color(0x40A29BFE), // primary dark @ 25%
    ),
    // Outer glow
    BoxShadow(
      offset: Offset.zero,
      blurRadius: 20,
      spreadRadius: 2,
      color: Color(0x1AA29BFE), // primary dark @ 10%
    ),
  ];
}
