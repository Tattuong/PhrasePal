import 'package:flutter/material.dart';

enum ShopItemType {
  theme,
  background,
  skin,
  feature,
  removeAds,
}

enum ShopItemCategory {
  themes,
  backgrounds,
  skins,
  features,
  premium,
}

class ShopItem {
  final String id;
  final String nameKey;
  final String descKey;
  final int price;
  final ShopItemType type;
  final ShopItemCategory category;
  final IconData icon;
  final bool oneTime;

  const ShopItem({
    required this.id,
    required this.nameKey,
    required this.descKey,
    required this.price,
    required this.type,
    required this.category,
    required this.icon,
    this.oneTime = true,
  });
}

class ShopCatalog {
  ShopCatalog._();

  static const String defaultThemeId = 'theme_default';
  static const String defaultBackgroundId = 'bg_default';
  static const String defaultSkinId = 'skin_default';

  static bool isDefaultId(String id) =>
      id == defaultThemeId || id == defaultBackgroundId || id == defaultSkinId;

  static const List<ShopItem> items = [
    ShopItem(
      id: defaultThemeId,
      nameKey: 'shopThemeDefault',
      descKey: 'shopThemeDefaultDesc',
      price: 0,
      type: ShopItemType.theme,
      category: ShopItemCategory.themes,
      icon: Icons.nights_stay_outlined,
    ),
    ShopItem(
      id: defaultBackgroundId,
      nameKey: 'shopBgDefault',
      descKey: 'shopBgDefaultDesc',
      price: 0,
      type: ShopItemType.background,
      category: ShopItemCategory.backgrounds,
      icon: Icons.crop_square_rounded,
    ),
    ShopItem(
      id: defaultSkinId,
      nameKey: 'shopSkinDefault',
      descKey: 'shopSkinDefaultDesc',
      price: 0,
      type: ShopItemType.skin,
      category: ShopItemCategory.skins,
      icon: Icons.texture_outlined,
    ),
    ShopItem(
      id: 'remove_ads',
      nameKey: 'shopRemoveAds',
      descKey: 'shopRemoveAdsDesc',
      price: 500,
      type: ShopItemType.removeAds,
      category: ShopItemCategory.premium,
      icon: Icons.block_outlined,
    ),
    ShopItem(
      id: 'theme_emerald',
      nameKey: 'shopThemeSakura',
      descKey: 'shopThemeSakuraDesc',
      price: 0,
      type: ShopItemType.theme,
      category: ShopItemCategory.themes,
      icon: Icons.local_florist_outlined,
    ),
    ShopItem(
      id: 'theme_gold',
      nameKey: 'shopThemeGold',
      descKey: 'shopThemeGoldDesc',
      price: 550,
      type: ShopItemType.theme,
      category: ShopItemCategory.themes,
      icon: Icons.star_outline_rounded,
    ),
    ShopItem(
      id: 'theme_midnight',
      nameKey: 'shopThemeMidnight',
      descKey: 'shopThemeMidnightDesc',
      price: 650,
      type: ShopItemType.theme,
      category: ShopItemCategory.themes,
      icon: Icons.dark_mode_outlined,
    ),
    ShopItem(
      id: 'bg_forest',
      nameKey: 'shopBgFuji',
      descKey: 'shopBgFujiDesc',
      price: 150,
      type: ShopItemType.background,
      category: ShopItemCategory.backgrounds,
      icon: Icons.landscape_outlined,
    ),
    ShopItem(
      id: 'bg_aurora',
      nameKey: 'shopBgWashi',
      descKey: 'shopBgWashiDesc',
      price: 180,
      type: ShopItemType.background,
      category: ShopItemCategory.backgrounds,
      icon: Icons.auto_awesome_outlined,
    ),
    ShopItem(
      id: 'bg_sunset',
      nameKey: 'shopBgDusk',
      descKey: 'shopBgDuskDesc',
      price: 180,
      type: ShopItemType.background,
      category: ShopItemCategory.backgrounds,
      icon: Icons.wb_twilight_outlined,
    ),
    ShopItem(
      id: 'skin_soft',
      nameKey: 'shopSkinSoft',
      descKey: 'shopSkinSoftDesc',
      price: 150,
      type: ShopItemType.skin,
      category: ShopItemCategory.skins,
      icon: Icons.rounded_corner,
    ),
    ShopItem(
      id: 'skin_neon',
      nameKey: 'shopSkinInk',
      descKey: 'shopSkinInkDesc',
      price: 200,
      type: ShopItemType.skin,
      category: ShopItemCategory.skins,
      icon: Icons.brush_outlined,
    ),
    ShopItem(
      id: 'feat_double_coins',
      nameKey: 'shopFeatDoubleCoins',
      descKey: 'shopFeatDoubleCoinsDesc',
      price: 450,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.monetization_on_outlined,
    ),
    ShopItem(
      id: 'feat_slow_audio',
      nameKey: 'shopFeatSlowAudio',
      descKey: 'shopFeatSlowAudioDesc',
      price: 300,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.slow_motion_video_outlined,
    ),
    ShopItem(
      id: 'feat_large_type',
      nameKey: 'shopFeatLargeType',
      descKey: 'shopFeatLargeTypeDesc',
      price: 250,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.format_size_rounded,
    ),
    ShopItem(
      id: 'feat_extra_cats',
      nameKey: 'shopFeatExtraCats',
      descKey: 'shopFeatExtraCatsDesc',
      price: 0,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.category_outlined,
    ),
    ShopItem(
      id: 'feat_quiz_plus',
      nameKey: 'shopFeatQuizPlus',
      descKey: 'shopFeatQuizPlusDesc',
      price: 280,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.quiz_outlined,
    ),
    ShopItem(
      id: 'lang_ko',
      nameKey: 'shopLangKo',
      descKey: 'shopLangKoDesc',
      price: 250,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.translate_rounded,
    ),
    ShopItem(
      id: 'lang_th',
      nameKey: 'shopLangTh',
      descKey: 'shopLangThDesc',
      price: 250,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.translate_rounded,
    ),
    ShopItem(
      id: 'lang_it',
      nameKey: 'shopLangIt',
      descKey: 'shopLangItDesc',
      price: 250,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.translate_rounded,
    ),
    ShopItem(
      id: 'lang_de',
      nameKey: 'shopLangDe',
      descKey: 'shopLangDeDesc',
      price: 250,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.translate_rounded,
    ),
    ShopItem(
      id: 'lang_zh',
      nameKey: 'shopLangZh',
      descKey: 'shopLangZhDesc',
      price: 250,
      type: ShopItemType.feature,
      category: ShopItemCategory.features,
      icon: Icons.translate_rounded,
    ),
  ];

  static ShopItem? find(String id) {
    for (final item in items) {
      if (item.id == id) return item;
    }
    return null;
  }
}
