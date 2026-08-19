import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../../core/constants/app_strings.dart';
import '../../core/navigation/app_navigator.dart';
import '../../data/phrase_catalog.dart';
import '../../models/app_theme_preset.dart';
import '../../providers/phrase_provider.dart';
import '../../providers/shop_provider.dart';
import '../../widgets/coin_purchase_sheet.dart';
import 'category_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phrases = context.watch<PhraseProvider>();
    final scale = context.select<ShopProvider, bool>((s) => s.hasLargeType) ? 1.08 : 1.0;
    final showAd = context.select<ShopProvider, bool>((s) => !s.hasRemoveAds);
    final ink = AppColors.ink(context);
    final cats = phrases.visibleCategories;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
      child: SafeArea(
        child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.t(context, 'appName'),
                      textAlign: TextAlign.center,
                      style: PpText.nunito(fontSize: 22, fontWeight: FontWeight.w800, color: ink),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
                    icon: Icon(Icons.settings_outlined, color: ink),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const _HeroArt(),
              Transform.translate(
                offset: const Offset(0, -28),
                child: _LanguageButton(
                  language: phrases.language,
                  onTap: () => _pickLanguage(context, phrases, context.read<ShopProvider>()),
                ),
              ),
              Text(AppStrings.t(context, 'pickSituation'), style: PpText.nunito(fontSize: 20, fontWeight: FontWeight.w800, color: ink)),
              const SizedBox(height: 12),
              ...cats.map((c) => _SituationTile(
                    category: c,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CategoryScreen(category: c))),
                  )),
              const SizedBox(height: 16),
              if (showAd) const _AdBox(),
            ],
          ),
        ),
      );
  }

  Future<void> _pickLanguage(BuildContext context, PhraseProvider phrases, ShopProvider shop) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFFDF9),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(color: AppColors.line(ctx), borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(height: 14),
                Text(AppStrings.t(ctx, 'language'), style: PpText.nunito(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF1A2E5A))),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(ctx).height * 0.5),
                  child: ListView(
                    shrinkWrap: true,
                    children: PhraseCatalog.languages.map((lang) {
                      final owned = shop.ownsLanguage(lang.id);
                      final selected = phrases.languageId == lang.id;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Material(
                          color: selected ? const Color(0xFFE8EEF8) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () async {
                              if (!owned) {
                                Navigator.pop(ctx);
                                AppTabs.goShop(features: true);
                                return;
                              }
                              await phrases.setLanguage(lang.id);
                              if (ctx.mounted) Navigator.pop(ctx);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: Row(
                                children: [
                                  _FlagChip(code: lang.flag, selected: selected),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(lang.name, style: PpText.nunito(fontWeight: FontWeight.w800, fontSize: 16, color: const Color(0xFF1A2E5A))),
                                  ),
                                  if (owned)
                                    Icon(selected ? Icons.check_circle_rounded : Icons.circle_outlined, color: selected ? Theme.of(ctx).colorScheme.primary : AppColors.muted(ctx), size: 22)
                                  else
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: AppColors.coin.withValues(alpha: 0.18),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.lock_rounded, size: 16, color: AppColors.coin),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeroArt extends StatelessWidget {
  const _HeroArt();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: 168,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primary, Color.lerp(primary, const Color(0xFF7A9AD4), 0.45)!],
                ),
              ),
            ),
            const Align(alignment: Alignment(0, 0.55), child: Icon(Icons.landscape_rounded, size: 120, color: Colors.white24)),
            const Align(alignment: Alignment(0.72, -0.2), child: Icon(Icons.temple_buddhist_rounded, size: 56, color: Colors.white70)),
            const Align(alignment: Alignment(-0.7, 0.15), child: Icon(Icons.local_florist_rounded, size: 40, color: Color(0xFFFFC1D0))),
          ],
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final TravelLanguage language;
  final VoidCallback onTap;

  const _LanguageButton({required this.language, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.translate_rounded, color: Colors.white, size: 22),
                const SizedBox(width: 10),
                Text(language.name, style: PpText.nunito(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(width: 8),
                const Icon(Icons.expand_more_rounded, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SituationTile extends StatelessWidget {
  final PhraseCategory category;
  final VoidCallback onTap;

  const _SituationTile({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final look = context.ftrTheme;
    final style = _catStyle(category.id);
    final skin = CardStyle.get(context.select<ShopProvider, String>((s) => s.activeSkinId));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(skin.paperRadius(16)),
          child: Ink(
            decoration: look.surfaceCard(radius: skin.paperRadius(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [style.$2, Color.lerp(style.$2, Colors.black, 0.18)!]),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: style.$2.withValues(alpha: 0.35), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Icon(style.$1, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppStrings.t(context, category.nameKey),
                      style: PpText.nunito(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.ink(context)),
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: AppColors.muted(context), size: 26),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

(IconData, Color) _catStyle(String id) => switch (id) {
      'airport' => (Icons.flight_rounded, const Color(0xFF2F6FED)),
      'hotel' => (Icons.apartment_rounded, const Color(0xFF2AA8A0)),
      'food' => (Icons.restaurant_rounded, const Color(0xFFE67A2E)),
      'shopping' => (Icons.shopping_bag_rounded, const Color(0xFF7B5CFF)),
      'emergency' => (Icons.add_box_rounded, const Color(0xFFD94A4A)),
      'transport' => (Icons.train_rounded, const Color(0xFF3D8B66)),
      'health' => (Icons.local_pharmacy_rounded, const Color(0xFF2E7D8A)),
      _ => (Icons.pin_rounded, const Color(0xFFC49A3C)),
    };

class _AdBox extends StatelessWidget {
  const _AdBox();

  @override
  Widget build(BuildContext context) {
    final billingOff = context.select<ShopProvider, bool>((s) => s.isBillingDisabled);
    return InkWell(
      onTap: billingOff ? null : () => CoinPurchaseSheet.show(context),
      borderRadius: BorderRadius.circular(16),
      child: CustomPaint(
        painter: _DashPainter(color: AppColors.line(context)),
        child: SizedBox(
          height: 72,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppStrings.t(context, 'adPlaceholder'), style: PpText.nunito(fontWeight: FontWeight.w800, color: AppColors.muted(context))),
                if (!billingOff)
                  Text(AppStrings.t(context, 'adPromo'), style: PpText.nunito(fontSize: 12, color: AppColors.muted(context))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  final Color color;
  _DashPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    const dash = 7.0;
    const gap = 5.0;
    final r = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16));
    final path = Path()..addRRect(r);
    for (final metric in path.computeMetrics()) {
      var dist = 0.0;
      while (dist < metric.length) {
        final next = (dist + dash).clamp(0, metric.length);
        canvas.drawPath(metric.extractPath(dist, next.toDouble()), paint);
        dist += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashPainter oldDelegate) => oldDelegate.color != color;
}

class _FlagChip extends StatelessWidget {
  final String code;
  final bool selected;

  const _FlagChip({required this.code, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: selected
              ? [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]
              : [const Color(0xFFE8EEF8), const Color(0xFFD5DDEC)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        code,
        style: PpText.nunito(
          fontWeight: FontWeight.w800,
          fontSize: 13,
          color: selected ? Colors.white : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
