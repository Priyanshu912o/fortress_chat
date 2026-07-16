import 'package:flutter/material.dart';

/// Fortress Light Mode Color Palette
/// Derived from the Stitch design prompt.
abstract final class ColoursLight {
  // ── Brightness ─────────────────────────────────────────────────────────────

  static const Brightness brightness = Brightness.light;
  // ── Primary Palette ───────────────────────────────────────────────────────

  static const Color primary = Color(0xFF6C5CE7);           // Primary buttons, active tabs, FAB
  static const Color onPrimary = Color(0xFFFFFFFF);          // Text/icons on primary (white on purple)
  static const Color primaryVariant = Color(0xFF5A4BD1);     // Pressed/hover states
  static const Color secondary = Color(0xFF00CEC9);          // Accents, online indicators, badges
  static const Color onSecondary = Color(0xFFFFFFFF);        // Text/icons on secondary (white on teal)
  static const Color secondaryVariant = Color(0xFF00B5B0);   // Secondary pressed states
  static const Color tertiary = Color(0xFFFD79A8);           // Notification dots, unread counts, alerts
  static const Color onTertiary = Color(0xFFFFFFFF);         // Text/icons on tertiary (white on pink)

  // ── Neutral Palette ───────────────────────────────────────────────────────

  static const Color background = Color(0xFFFAFBFE);        // Page backgrounds
  static const Color surface = Color(0xFFFFFFFF);            // Cards, sheets, dialogs
  static const Color surfaceVariant = Color(0xFFF0F2F8);     // Chat bubbles (received), input fields
  static const Color onBackground = Color(0xFF1A1A2E);       // Primary text
  static const Color onSurface = Color(0xFF2D3748);          // Secondary text
  static const Color onSurfaceMuted = Color(0xFF8896AB);     // Timestamps, helper text
  static const Color divider = Color(0xFFE8ECF2);            // Separators, borders

  // ── Semantic Colors ───────────────────────────────────────────────────────

  static const Color success = Color(0xFF00B894);            // Delivered/read indicators
  static const Color onSuccess = Color(0xFFFFFFFF);          // Text/icons on success (white on green)
  static const Color warning = Color(0xFFFDCB6E);            // Warnings
  static const Color onWarning = Color(0xFF1A1A2E);          // Text/icons on warning (dark on yellow for readability)
  static const Color error = Color(0xFFE17055);              // Errors, destructive actions
  static const Color onError = Color(0xFFFFFFFF);            // Text/icons on error (white on coral)
  static const Color encrypted = Color(0x1A6C5CE7);          // Subtle tint behind encryption indicators (10% opacity)

  // ── Chat Bubble Colors ────────────────────────────────────────────────────

  // Sent bubble uses gradientPrimary — see gradients.dart
  static const Color bubbleReceived = Color(0xFFF0F2F8);     // Received messages
  static const Color onBubbleSent = Color(0xFFFFFFFF);       // Text on sent bubbles
  static const Color onBubbleReceived = Color(0xFF2D3748);   // Text on received bubbles
}
