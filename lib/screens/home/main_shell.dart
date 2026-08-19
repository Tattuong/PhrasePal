import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/navigation/app_navigator.dart';
import '../../core/services/sound_service.dart';
import '../../models/app_theme_preset.dart';
import '../../providers/shop_provider.dart';
import '../../widgets/app_scaffold.dart';
import '../shop/shop_screen.dart';
import 'home_screen.dart';
import 'saved_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  void initState() {
    super.initState();
    AppTabs.index.addListener(_onTab);
  }

  void _onTab() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    AppTabs.index.removeListener(_onTab);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final index = AppTabs.index.value;
    context.select<ShopProvider, String>((s) => '${s.activeThemeId}|${s.activeBackgroundId}|${s.activeSkinId}');
    final look = context.ftrTheme;
    const pages = [
      HomeScreen(),
      SavedScreen(),
      ShopScreen(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FtrBackground(
        child: IndexedStack(
          index: index,
          children: [
            for (final page in pages) RepaintBoundary(child: page),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: look.navBar,
          border: Border(top: BorderSide(color: look.border)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.chat_bubble_outline_rounded, label: AppStrings.t(context, 'navHome'), selected: index == 0, onTap: () { SoundService.instance.tap(); AppTabs.goHome(); }),
                _NavItem(icon: Icons.star_outline_rounded, label: AppStrings.t(context, 'navSaved'), selected: index == 1, onTap: () { SoundService.instance.tap(); AppTabs.goSaved(); }),
                _NavItem(icon: Icons.storefront_outlined, label: AppStrings.t(context, 'navShop'), selected: index == 2, onTap: () { SoundService.instance.tap(); AppTabs.goShop(); }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = selected ? context.lumenAccent : AppColors.muted(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(fontSize: 10, fontWeight: selected ? FontWeight.w800 : FontWeight.w600, color: color, height: 1.1),
            ),
          ],
        ),
      ),
    );
  }
}
