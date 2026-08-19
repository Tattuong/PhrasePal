import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/navigation/app_navigator.dart';
import 'core/services/storage_service.dart';
import 'models/app_theme_preset.dart';
import 'providers/phrase_provider.dart';
import 'providers/shop_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/shop/shop_screen.dart';
import 'screens/splash_screen.dart';
import 'widgets/coin_reward_listener.dart';

late final ThemeProvider appThemeProvider;
late final PhraseProvider appPhraseProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();

  appThemeProvider = ThemeProvider();
  await appThemeProvider.init();

  appPhraseProvider = PhraseProvider();

  runApp(const PhrasePalApp());
}

class PhrasePalApp extends StatelessWidget {
  const PhrasePalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appThemeProvider),
        ChangeNotifierProvider(create: (_) {
          final shop = ShopProvider();
          appPhraseProvider.bindShop(shop);
          shop.init();
          return shop;
        }),
        ChangeNotifierProvider.value(value: appPhraseProvider),
      ],
      child: const _MaterialRoot(),
    );
  }
}

class _MaterialRoot extends StatelessWidget {
  const _MaterialRoot();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.select<ThemeProvider, ThemeMode>((t) => t.themeMode);
    final themeId = context.select<ShopProvider, String>((s) => s.activeThemeId);
    final preset = AppThemePresets.get(themeId);

    return MaterialApp(
      navigatorKey: rootNavigatorKey,
      title: 'PhrasePal',
      debugShowCheckedModeBanner: false,
      theme: AppThemeCache.light(preset),
      darkTheme: AppThemeCache.dark(preset),
      themeMode: themeMode,
      locale: const Locale('en'),
      builder: (context, child) => CoinRewardListener(child: child ?? const SizedBox.shrink()),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: const SplashScreen(),
      routes: {
        '/shop': (_) => const ShopScreen(),
        '/privacy': (_) => const PrivacyPolicyScreen(),
      },
    );
  }
}
