import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/phrase_catalog.dart';
import '../../models/app_theme_preset.dart';
import '../../providers/phrase_provider.dart';
import '../../providers/shop_provider.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_toast.dart';

class CategoryScreen extends StatelessWidget {
  final PhraseCategory category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final phrases = context.watch<PhraseProvider>();
    final shop = context.watch<ShopProvider>();
    final list = phrases.phrasesIn(category.id);
    final skin = shop.activeCardStyle;
    final large = shop.hasLargeType;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FtrBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 12, 0),
                child: Row(
                  children: [
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
                    Expanded(
                      child: Text(
                        AppStrings.t(context, category.nameKey),
                        style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.ink(context)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Material(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _playAll(context, phrases, list),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Icon(Icons.volume_up_rounded, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.t(context, 'playAll'), style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
                                Text(AppStrings.t(context, 'playAllDesc'), style: GoogleFonts.nunito(fontSize: 12, color: AppColors.muted(context))),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => _PhraseCard(phrase: list[i], skin: skin, large: large),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhraseCard extends StatelessWidget {
  final Phrase phrase;
  final CardStyle skin;
  final bool large;

  const PhraseCard({super.key, required this.phrase, required this.skin, required this.large});

  @override
  Widget build(BuildContext context) => _PhraseCard(phrase: phrase, skin: skin, large: large);
}

class _PhraseCard extends StatelessWidget {
  final Phrase phrase;
  final CardStyle skin;
  final bool large;

  const _PhraseCard({required this.phrase, required this.skin, required this.large});

  @override
  Widget build(BuildContext context) {
    final phrases = context.watch<PhraseProvider>();
    final fav = phrases.isFavorite(phrase.id);
    final playing = phrases.isPlaying(phrase.id);
    final look = context.ftrTheme;
    return DecoratedBox(
      decoration: look.surfaceCard(radius: skin.paperRadius(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
        child: Row(
          children: [
            IconButton(
              onPressed: () => phrases.toggleFavorite(phrase),
              icon: Icon(
                fav ? Icons.star_rounded : Icons.star_rounded,
                color: fav ? AppColors.coin : const Color(0xFFD8D2C8),
                size: 26,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(phrase.native, style: GoogleFonts.nunito(fontSize: large ? 20 : 16, fontWeight: FontWeight.w800, color: AppColors.ink(context))),
                  const SizedBox(height: 2),
                  Text(phrase.romanization, style: GoogleFonts.nunito(fontSize: 13, color: AppColors.muted(context))),
                  Text(phrase.english, style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink(context).withValues(alpha: 0.75))),
                ],
              ),
            ),
            Material(
              color: playing ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
              shape: const CircleBorder(),
              elevation: 2,
              shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  HapticFeedback.selectionClick();
                  _speak(context, phrases, phrase);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(playing ? Icons.graphic_eq_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _speak(BuildContext context, PhraseProvider phrases, Phrase phrase) async {
  final ok = await phrases.speak(phrase);
  if (!ok && context.mounted) {
    AppToast.show(context, title: AppStrings.t(context, 'audioError'), icon: Icons.volume_off_rounded);
  }
}

Future<void> _playAll(BuildContext context, PhraseProvider phrases, List<Phrase> list) async {
  final ok = await phrases.playAll(list);
  if (!ok && context.mounted) {
    AppToast.show(context, title: AppStrings.t(context, 'audioError'), icon: Icons.volume_off_rounded);
  }
}
