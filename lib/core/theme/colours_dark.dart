import 'package:flutter/material.dart';

/// Fortress Dark Mode Color Palette
/// Derived from the Stitch design prompt.
/// Deep navy/charcoal surfaces — not pure black.
/// Slightly brighter accent colors for WCAG contrast.
abstract final class ColoursDark {
  // ── Brightness ─────────────────────────────────────────────────────────────

  static const Brightness brightness = Brightness.dark;
  // ── Primary Palette ───────────────────────────────────────────────────────

  static const Color primary = Color(0xFFA29BFE);           // Primary buttons, active tabs, FAB
  static const Color onPrimary = Color(0xFF0D1117);          // Text/icons on primary (dark on light purple)
  static const Color primaryVariant = Color(0xFF8B7FF0);     // Pressed/hover states
  static const Color secondary = Color(0xFF55EFC4);          // Accents, online indicators, badges
  static const Color onSecondary = Color(0xFF0D1117);        // Text/icons on secondary (dark on bright mint)
  static const Color secondaryVariant = Color(0xFF3DE0AC);   // Secondary pressed states
  static const Color tertiary = Color(0xFFFF9CC2);           // Notification dots, unread counts, alerts
  static const Color onTertiary = Color(0xFF0D1117);         // Text/icons on tertiary (dark on light pink)

  // ── Neutral Palette ───────────────────────────────────────────────────────

  static const Color background = Color(0xFF0D1117);         // Page backgrounds
  static const Color surface = Color(0xFF161B22);            // Cards, sheets, dialogs
  static const Color surfaceVariant = Color(0xFF1C2333);     // Chat bubbles (received), input fields
  static const Color onBackground = Color(0xFFE6EDF3);       // Primary text
  static const Color onSurface = Color(0xFFC9D1D9);          // Secondary text
  static const Color onSurfaceMuted = Color(0xFF6E7C8A);     // Timestamps, helper text
  static const Color divider = Color(0xFF21262D);            // Separators, borders

  // ── Semantic Colors ───────────────────────────────────────────────────────

  static const Color success = Color(0xFF55EFC4);            // Delivered/read indicators
  static const Color onSuccess = Color(0xFF0D1117);          // Text/icons on success (dark on bright mint)
  static const Color warning = Color(0xFFFFEAA7);            // Warnings
  static const Color onWarning = Color(0xFF0D1117);          // Text/icons on warning (dark on pale yellow)
  static const Color error = Color(0xFFFF7675);              // Errors, destructive actions
  static const Color onError = Color(0xFF0D1117);            // Text/icons on error (dark on light coral)
  static const Color encrypted = Color(0x14A29BFE);          // Subtle tint behind encryption indicators (8% opacity)

  // ── Chat Bubble Colors ────────────────────────────────────────────────────

  // Sent bubble uses gradientPrimaryDark — see gradients.dart
  static const Color bubbleReceived = Color(0xFF1C2333);     // Received messages
  static const Color onBubbleSent = Color(0xFFFFFFFF);       // Text on sent bubbles
  static const Color onBubbleReceived = Color(0xFFC9D1D9);   // Text on received bubbles
}
