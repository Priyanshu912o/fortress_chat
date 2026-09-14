/// Fortress Spacing System
/// All values in logical pixels (dp).
abstract final class AppSpacing {
  static const double space2 = 2;      // Inline icon-text gap
  static const double space4 = 4;      // Tight inner padding
  static const double space8 = 8;      // Standard inner padding
  static const double space12 = 12;    // Between list items
  static const double space16 = 16;    // Page horizontal padding
  static const double space20 = 20;    // Between sections
  static const double space24 = 24;    // Card inner padding
  static const double space32 = 32;    // Major section spacing
  static const double space48 = 48;    // Between page blocks

  // ── Standard Size Aliases ──────────────────────────────────────────────────
  static const double xs = space4;
  static const double sm = space8;
  static const double md = space16;
  static const double lg = space24;
  static const double xl = space32;

  // ── Page Margins ──────────────────────────────────────────────────────────

  static const double marginMobile = space16;    // Horizontal page padding on phones
  static const double marginDesktop = space32;   // Horizontal page padding on larger screens
}