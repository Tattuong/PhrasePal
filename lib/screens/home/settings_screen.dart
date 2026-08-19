import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/navigation/app_navigator.dart';
import '../../core/services/sound_service.dart';
import '../../models/app_theme_preset.dart';
import '../../providers/phrase_provider.dart';
import '../../providers/shop_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_toast.dart';
import '../privacy_policy_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final shop = context.watch<ShopProvider>();
    final phrases = context.watch<PhraseProvider>();
    final ink = AppColors.ink(context);
    final accent = context.lumenAccent;
    final muted = AppColors.muted(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FtrBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 36),
            children: [
              Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_rounded, color: ink),
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.t(context, 'settings'),
                      style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w800, color: accent, height: 1.05),
                    ),
                  ),
                ],
              ),
              _SectionLabel(AppStrings.t(context, 'appearance')),
              _Group(
                children: [
                  _Row(
                    icon: Icons.palette_outlined,
                    title: AppStrings.t(context, 'currentLook'),
                    subtitle: _lookName(context, shop),
                  ),
                  if (!shop.isDefaultLook)
                    _Row(
                      icon: Icons.restart_alt_rounded,
                      title: AppStrings.t(context, 'resetDefault'),
                      subtitle: AppStrings.t(context, 'resetDefaultDesc'),
                      trailing: Icon(Icons.chevron_right_rounded, color: muted),
                      onTap: () async {
                        SoundService.instance.tap();
                        await shop.resetLookToDefault();
                        if (context.mounted) {
                          AppToast.show(context, title: AppStrings.t(context, 'lookResetDone'));
                        }
                      },
                    ),
                  _Row(
                    icon: Icons.dark_mode_outlined,
                    title: AppStrings.t(context, 'darkMode'),
                    trailing: Switch(value: theme.isDarkMode, onChanged: (_) => theme.toggleTheme()),
                  ),
                  if (shop.hasSlowAudio)
                    _Row(
                      icon: Icons.slow_motion_video_outlined,
                      title: AppStrings.t(context, 'slowAudio'),
                      trailing: Switch(
                        value: phrases.slowPlayback,
                        onChanged: (v) => phrases.setSlowPlayback(v),
                      ),
                    ),
                  _Row(
                    icon: Icons.storefront_outlined,
                    title: AppStrings.t(context, 'shop'),
                    trailing: Icon(Icons.chevron_right_rounded, color: muted),
                    onTap: () {
                      Navigator.pop(context);
                      AppTabs.goShop();
                    },
                  ),
                ],
              ),
              _SectionLabel(AppStrings.t(context, 'about')),
              _Group(
                children: [
                  _Row(
                    icon: Icons.privacy_tip_outlined,
                    title: AppStrings.t(context, 'privacyPolicy'),
                    trailing: Icon(Icons.chevron_right_rounded, color: muted),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen())),
                  ),
                  if (!shop.isBillingDisabled)
                    _Row(
                      icon: Icons.restore_rounded,
                      title: AppStrings.t(context, 'restorePurchases'),
                      onTap: () => shop.restorePurchases(),
                    ),
                  _Row(
                    icon: Icons.info_outline_rounded,
                    title: AppStrings.t(context, 'about'),
                    subtitle: AppStrings.t(context, 'version', {'v': '1.0.0'}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _lookName(BuildContext context, ShopProvider shop) {
    final parts = <String>[
      AppStrings.t(context, ShopCatalogLookup.nameKey(shop.activeThemeId)),
      AppStrings.t(context, ShopCatalogLookup.nameKey(shop.activeBackgroundId)),
      AppStrings.t(context, ShopCatalogLookup.nameKey(shop.activeSkinId)),
    ];
    return parts.join(' · ');
  }
}

class ShopCatalogLookup {
  static String nameKey(String id) {
    switch (id) {
      case 'theme_default':
        return 'shopThemeDefault';
      case 'theme_emerald':
        return 'shopThemeSakura';
      case 'theme_gold':
        return 'shopThemeGold';
      case 'theme_midnight':
        return 'shopThemeMidnight';
      case 'bg_default':
        return 'shopBgDefault';
      case 'bg_forest':
        return 'shopBgFuji';
      case 'bg_aurora':
        return 'shopBgWashi';
      case 'bg_sunset':
        return 'shopBgDusk';
      case 'skin_default':
        return 'shopSkinDefault';
      case 'skin_soft':
        return 'shopSkinSoft';
      case 'skin_neon':
        return 'shopSkinInk';
      default:
        return id;
    }
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 18, 4, 8),
      child: Text(text, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, color: AppColors.muted(context))),
    );
  }
}

class _Group extends StatelessWidget {
  final List<Widget> children;
  const _Group({required this.children});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: context.ftrTheme.surfaceCard(radius: 18),
      child: Column(children: children),
    );
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _Row({required this.icon, required this.title, this.subtitle, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: context.lumenAccent),
      title: Text(title, style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
      subtitle: subtitle == null ? null : Text(subtitle!, style: GoogleFonts.nunito(fontSize: 12, color: AppColors.muted(context))),
      trailing: trailing,
    );
  }
}
