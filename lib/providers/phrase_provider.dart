import 'package:flutter/material.dart';

import '../core/services/storage_service.dart';
import '../core/services/tts_service.dart';
import '../data/phrase_catalog.dart';
import 'shop_provider.dart';

class PhraseProvider extends ChangeNotifier {
  static const _langKey = 'pp_language';
  static const _favKey = 'pp_favorites';
  static const _onboardKey = 'pp_onboarding_done';

  ShopProvider? _shop;

  String _languageId = 'ja';
  Set<String> _favorites = {};
  bool _onboardingComplete = false;
  bool _slowPlayback = false;
  String? _playingId;

  String get languageId => _languageId;
  bool get onboardingComplete => _onboardingComplete;
  bool get slowPlayback => _slowPlayback;
  Set<String> get favorites => _favorites;
  TravelLanguage get language => PhraseCatalog.languageById(_languageId);

  void bindShop(ShopProvider shop) => _shop = shop;

  List<PhraseCategory> get visibleCategories {
    final extra = _shop?.hasExtraCategories ?? false;
    return PhraseCatalog.categories.where((c) => !c.extra || extra).toList();
  }

  List<Phrase> get phrases =>
      PhraseCatalog.forLanguage(_languageId, extra: _shop?.hasExtraCategories ?? false);

  List<Phrase> phrasesIn(String categoryId) =>
      phrases.where((p) => p.categoryId == categoryId).toList();

  List<Phrase> get savedPhrases => phrases.where((p) => _favorites.contains(p.id)).toList();

  int get travelStreak => _shop?.loginStreak ?? 0;

  Future<void> init() async {
    _languageId = await StorageService.instance.getString(_langKey) ?? 'ja';
    _favorites = (await StorageService.instance.getStringList(_favKey))?.toSet() ?? {};
    _onboardingComplete = await StorageService.instance.getBool(_onboardKey) ?? false;
    _slowPlayback = await StorageService.instance.getBool('pp_slow_on') ?? false;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _onboardingComplete = true;
    await StorageService.instance.saveBool(_onboardKey, true);
    notifyListeners();
  }

  Future<void> setLanguage(String id) async {
    if (_shop != null && !_shop!.ownsLanguage(id)) return;
    _languageId = id;
    await StorageService.instance.saveString(_langKey, id);
    notifyListeners();
  }

  Future<void> setSlowPlayback(bool value) async {
    if (value && _shop != null && !_shop!.hasSlowAudio) return;
    _slowPlayback = value;
    await StorageService.instance.saveBool('pp_slow_on', value);
    notifyListeners();
  }

  Future<void> toggleFavorite(Phrase phrase) async {
    if (_favorites.contains(phrase.id)) {
      _favorites.remove(phrase.id);
    } else {
      _favorites.add(phrase.id);
      await _shop?.rewardForFavorite();
    }
    await StorageService.instance.saveStringList(_favKey, _favorites.toList());
    notifyListeners();
  }

  bool isFavorite(String id) => _favorites.contains(id);

  bool isPlaying(String id) => _playingId == id;

  Future<bool> speak(Phrase phrase) async {
    _playingId = phrase.id;
    notifyListeners();
    final slow = _slowPlayback && (_shop?.hasSlowAudio ?? false);
    try {
      return await TtsService.instance.speak(
        text: phrase.native,
        fallback: phrase.romanization,
        langCode: language.ttsCode,
        phraseId: phrase.id,
        slow: slow,
      );
    } finally {
      if (_playingId == phrase.id) {
        _playingId = null;
        notifyListeners();
      }
    }
  }

  Future<bool> playAll(List<Phrase> list) async {
    for (final phrase in list) {
      final ok = await speak(phrase);
      if (!ok) return false;
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
    return true;
  }
}
