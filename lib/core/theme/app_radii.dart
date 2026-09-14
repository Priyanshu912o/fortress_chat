import 'package:flutter/material.dart';

/// Fortress Border Radii Tokens
/// All values in logical pixels (dp).
abstract final class AppRadii {
  // ── Raw Values ────────────────────────────────────────────────────────────

  static const double smallValue = 8;       // Chips, small buttons
  static const double mediumValue = 12;     // Input fields, cards
  static const double largeValue = 16;      // Chat bubbles
  static const double xLargeValue = 24;     // Bottom sheets, modals
  static const double circleValue = 999;    // Avatars, FAB

  // ── Component Aliases ──────────────────────────────────────────────────────
  static const double card = mediumValue;
  static const double button = smallValue;
  static const double sheet = xLargeValue;
  static const double input = mediumValue;
  static const double dialog = largeValue;
  static const double tag = smallValue;

  // ── BorderRadius Shortcuts ────────────────────────────────────────────────

  static final BorderRadius small = BorderRadius.circular(smallValue);     // Chips, small buttons
  static final BorderRadius medium = BorderRadius.circular(mediumValue);   // Input fields, cards
  static final BorderRadius large = BorderRadius.circular(largeValue);     // Chat bubbles
  static final BorderRadius xLarge = BorderRadius.circular(xLargeValue);   // Bottom sheets, modals
  static final BorderRadius circle = BorderRadius.circular(circleValue);   // Avatars, FAB

  // ── Chat Bubble Radii (asymmetric) ────────────────────────────────────────

  /// Sent bubble: rounded with sharper bottom-right (8dp)
  static const BorderRadius bubbleSent = BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(8),    // Sharper corner pointing to sender
  );

  /// Received bubble: rounded with sharper bottom-left (8dp)
  static const BorderRadius bubbleReceived = BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(8),     // Sharper corner pointing to sender
    bottomRight: Radius.circular(16),
  );
}
