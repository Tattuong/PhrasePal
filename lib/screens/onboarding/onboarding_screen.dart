import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/sound_service.dart';
import '../../core/constants/app_strings.dart';
import '../../models/app_theme_preset.dart';
import '../../providers/phrase_provider.dart';
import '../../widgets/app_scaffold.dart';
import '../home/main_shell.dart';
import '../../core/constants/app_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  static const _pages = [
    ('onboardTitle1', 'onboardDesc1', Icons.menu_book_outlined),
    ('onboardTitle2', 'onboardDesc2', Icons.mic_off_rounded),
    ('onboardTitle3', 'onboardDesc3', Icons.wifi_off_rounded),
  ];

  Future<void> _finish() async {
    SoundService.instance.levelComplete();
    await context.read<PhraseProvider>().completeOnboarding();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (_) => const MainShell()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ftr = context.ftrTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FtrBackground(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _finish,
                  child: Text(
                    AppStrings.t(context, 'skipOnboard'),
                    style: TextStyle(color: ftr.primaryLight.withValues(alpha: 0.85)),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, index) {
                    final (titleKey, descKey, icon) = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, size: 72, color: ftr.primary),
                          const SizedBox(height: 28),
                          Text(
                            AppStrings.t(context, titleKey),
                            textAlign: TextAlign.center,
                            style: PpText.nunito(fontSize: 26, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppStrings.t(context, descKey),
                            textAlign: TextAlign.center,
                            style: PpText.nunito(fontSize: 16, height: 1.45, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (i) => Container(
                    width: _page == i ? 18 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                    decoration: BoxDecoration(
                      color: _page == i ? ftr.primary : ftr.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      if (_page < _pages.length - 1) {
                        _pageController.nextPage(duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
                      } else {
                        _finish();
                      }
                    },
                    child: Text(
                      _page < _pages.length - 1 ? AppStrings.t(context, 'next') : AppStrings.t(context, 'getStarted'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
