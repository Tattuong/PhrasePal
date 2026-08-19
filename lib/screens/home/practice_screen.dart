import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/phrase_catalog.dart';
import '../../providers/phrase_provider.dart';
import '../../providers/shop_provider.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_toast.dart';
import '../../core/constants/app_fonts.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late List<Phrase> _queue;
  int _index = 0;
  int _ok = 0;
  bool _revealed = false;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    final phrases = context.read<PhraseProvider>();
    final shop = context.read<ShopProvider>();
    final source = phrases.savedPhrases.isNotEmpty ? phrases.savedPhrases : phrases.phrases;
    final take = shop.hasQuizPlus ? 8 : 5;
    _queue = [...source]..shuffle(Random());
    if (_queue.length > take) _queue = _queue.take(take).toList();
  }

  Phrase get _current => _queue[_index];

  Future<void> _mark(bool correct) async {
    if (correct) _ok++;
    if (_index >= _queue.length - 1) {
      await context.read<ShopProvider>().rewardForPractice();
      setState(() => _done = true);
      return;
    }
    setState(() {
      _index++;
      _revealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final phrases = context.watch<PhraseProvider>();
    final ink = AppColors.ink(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FtrBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: _done
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.t(context, 'practiceDone'), style: PpText.nunito(fontSize: 26, fontWeight: FontWeight.w800, color: ink)),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.t(context, 'practiceScore', {'ok': '$_ok', 'total': '${_queue.length}'}),
                        style: PpText.nunito(color: AppColors.muted(context)),
                      ),
                      const SizedBox(height: 24),
                      FilledButton(onPressed: () => Navigator.pop(context), child: Text(AppStrings.t(context, 'continue'))),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                          Expanded(
                            child: Text(AppStrings.t(context, 'practiceTitle'), style: PpText.nunito(fontWeight: FontWeight.w800, fontSize: 18)),
                          ),
                          Text('${_index + 1}/${_queue.length}'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(_current.english, textAlign: TextAlign.center, style: PpText.nunito(fontSize: 22, fontWeight: FontWeight.w800, color: ink)),
                      const SizedBox(height: 20),
                      if (_revealed) ...[
                        Text(_current.native, textAlign: TextAlign.center, style: PpText.nunito(fontSize: 20, fontWeight: FontWeight.w800)),
                        Text(_current.romanization, textAlign: TextAlign.center, style: PpText.nunito(color: AppColors.muted(context))),
                      ],
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final ok = await phrases.speak(_current);
                          if (!ok && context.mounted) {
                            AppToast.show(context, title: AppStrings.t(context, 'audioError'), icon: Icons.volume_off_rounded);
                          }
                        },
                        icon: const Icon(Icons.volume_up_rounded),
                        label: Text(AppStrings.t(context, 'hearAgain')),
                      ),
                      const SizedBox(height: 8),
                      if (!_revealed)
                        FilledButton(onPressed: () => setState(() => _revealed = true), child: const Text('Show'))
                      else
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(onPressed: () => _mark(false), child: Text(AppStrings.t(context, 'wrong'))),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FilledButton(onPressed: () => _mark(true), child: Text(AppStrings.t(context, 'correct'))),
                            ),
                          ],
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
