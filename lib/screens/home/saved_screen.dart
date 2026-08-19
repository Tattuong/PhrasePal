import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/phrase_provider.dart';
import '../../providers/shop_provider.dart';
import '../../widgets/app_scaffold.dart';
import 'category_screen.dart';
import 'practice_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phrases = context.watch<PhraseProvider>();
    final shop = context.watch<ShopProvider>();
    final saved = phrases.savedPhrases;
    final skin = shop.activeCardStyle;
    final streak = shop.loginStreak.clamp(1, 7);
    final ink = AppColors.ink(context);

    return FtrBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(AppStrings.t(context, 'savedPhrases'), style: GoogleFonts.nunito(fontSize: 26, fontWeight: FontWeight.w800, color: ink)),
                ),
                Icon(Icons.star_rounded, color: AppColors.coin),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.t(context, 'travelStreak'), style: GoogleFonts.nunito(color: Colors.white70, fontWeight: FontWeight.w700)),
                  Text(AppStrings.t(context, 'days', {'n': '${shop.loginStreak}'}), style: GoogleFonts.nunito(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (i) {
                      final on = i < streak;
                      return CircleAvatar(
                        radius: 14,
                        backgroundColor: on ? AppColors.coin : Colors.white24,
                        child: Icon(on ? Icons.check_rounded : Icons.star_border_rounded, size: 14, color: on ? AppColors.primary : Colors.white54),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE7F6EA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.cloud_off_rounded, color: Color(0xFF2E7D4F)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.t(context, 'offlineBanner'), style: GoogleFonts.nunito(fontWeight: FontWeight.w800, color: const Color(0xFF1B5E38))),
                        Text(AppStrings.t(context, 'offlineBannerDesc'), style: GoogleFonts.nunito(fontSize: 12, color: const Color(0xFF2E7D4F))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(AppStrings.t(context, 'yourFavorites'), style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w800, color: ink)),
            const SizedBox(height: 10),
            if (saved.isEmpty)
              Text(AppStrings.t(context, 'noFavorites'), style: GoogleFonts.nunito(color: AppColors.muted(context)))
            else
              ...saved.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PhraseCard(phrase: p, skin: skin, large: shop.hasLargeType),
                  )),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.t(context, 'quickPractice'), style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  Text(AppStrings.t(context, 'quickPracticeDesc'), style: GoogleFonts.nunito(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Theme.of(context).colorScheme.primary),
                      onPressed: saved.isEmpty
                          ? null
                          : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PracticeScreen())),
                      child: Text(AppStrings.t(context, 'startPractice')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
