import 'package:flutter/material.dart';

/// PhrasePal — navy, cream, gold.
class AppColors {
  static const Color primary = Color(0xFF1A2E5A);
  static const Color primaryLight = Color(0xFF3D5A99);
  static const Color primarySoft = Color(0xFFE8EEF8);
  static const Color primaryMuted = Color(0xFF4A628C);

  static const Color accent = Color(0xFF1A2E5A);
  static const Color accentLight = Color(0xFF3D5A99);
  static const Color accentDeep = Color(0xFF122044);
  static const Color success = Color(0xFF3D8B66);
  static const Color successDeep = Color(0xFF2A6248);
  static const Color warning = Color(0xFFC49A3C);
  static const Color error = Color(0xFFD94A4A);
  static const Color coin = Color(0xFFD4A83A);
  static const Color onGold = Color(0xFFFFFFFF);

  static const Color background = Color(0xFFF9F6F0);
  static const Color surface = Color(0xFFFFFDF9);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0EBE3);
  static const Color border = Color(0xFFE2DDD4);
  static const Color borderBright = Color(0xFF1A2E5A);

  static const Color textPrimary = Color(0xFFF9F6F0);
  static const Color textSecondary = Color(0xFFB8C0D0);
  static const Color textMuted = Color(0xFF6B7380);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1A2E5A);
  static const Color onSurfaceVariant = textMuted;

  static const Color navBar = Color(0xFF122044);
  static const Color navActive = primary;
  static const Color navInactive = Color(0xFF8A93A6);

  static const Color darkBackground = Color(0xFF0E1628);
  static const Color darkSurface = Color(0xFF182338);
  static const Color darkCard = Color(0xFF22304A);
  static const Color trueBlack = Color(0xFF0A1020);
  static const Color darkInk = Color(0xFFF4F2FA);

  static const Color lightBackground = background;
  static const Color lightSurface = surface;
  static const Color lightPrimaryTint = Color(0xFFE8EEF8);
  static const Color lightWarmTint = Color(0xFFF9F6F0);
  static const Color lightTextPrimary = Color(0xFF1A2E5A);

  static const Color salon = Color(0xFF122044);
  static const Color salonCard = Color(0xFF1A2E5A);
  static const Color salonLine = Color(0xFF3D5A99);

  static const List<Color> papers = [
    Color(0xFFFFFFFF),
    Color(0xFFF9F6F0),
    Color(0xFFE8EEF8),
    Color(0xFFFFF5F7),
  ];

  static Color ink(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkInk : lightTextPrimary;

  static Color muted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? textSecondary : textMuted;

  static Color card(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    if (Theme.of(context).brightness == Brightness.light) {
      return Color.lerp(surface, Colors.white, 0.4) ?? Colors.white;
    }
    return Color.lerp(surface, Colors.white, 0.08) ?? darkCard;
  }

  static Color line(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? const Color(0xFF2C3A55) : border;

  static Color navBarColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? navBar : Colors.white;

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1A2E5A), Color(0xFF122044)],
  );

  static const LinearGradient gameGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF9F6F0), Color(0xFFF3EEE6)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3D5A99), Color(0xFF1A2E5A)],
  );

  static const LinearGradient primaryGradient = accentGradient;
  static const LinearGradient heroGradient = headerGradient;
  static const LinearGradient goldShimmer = LinearGradient(colors: [Color(0xFFE8C56A), Color(0xFFD4A83A)]);
  static const LinearGradient shopPromoGradient = headerGradient;
  static const LinearGradient vipGoldGradient = LinearGradient(
    colors: [Color(0xFFE8C56A), Color(0xFFD4A83A), Color(0xFFB8862A)],
  );
  static const LinearGradient shopVipHeroGradient = headerGradient;
  static const LinearGradient successGradient = LinearGradient(colors: [Color(0xFF5CBA8A), Color(0xFF3D8B66)]);
  static const LinearGradient cardGlow = LinearGradient(colors: [Color(0xFF22304A), Color(0xFF182338)]);

  static List<BoxShadow> softShadow({double opacity = 0.08}) => [
        BoxShadow(
          color: const Color(0xFF1A2E5A).withValues(alpha: opacity),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ];
}
