import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TtsService {
  TtsService._();
  static final TtsService instance = TtsService._();

  final AudioPlayer _player = AudioPlayer(playerId: 'phrasepal');
  String? lastError;
  bool _inited = false;

  Future<void> init() async {
    if (_inited) return;
    try {
      await _player.setReleaseMode(ReleaseMode.stop);
      await _player.setPlayerMode(PlayerMode.mediaPlayer);
      await _player.setVolume(1);
      await _player.setAudioContext(
        AudioContext(
          android: const AudioContextAndroid(
            isSpeakerphoneOn: false,
            contentType: AndroidContentType.music,
            usageType: AndroidUsageType.media,
            audioFocus: AndroidAudioFocus.gain,
          ),
        ),
      );
      _inited = true;
    } catch (e) {
      debugPrint('TTS init: $e');
      _inited = true;
    }
  }

  Future<bool> speak({
    required String text,
    required String fallback,
    required String langCode,
    required String phraseId,
    bool slow = false,
  }) async {
    lastError = null;
    HapticFeedback.selectionClick();
    await init();

    try {
      await _player.stop();
      await _player.setPlaybackRate(slow ? 0.78 : 1);
      final done = Completer<void>();
      StreamSubscription<void>? sub;
      sub = _player.onPlayerComplete.listen((_) {
        if (!done.isCompleted) done.complete();
      });
      await _player.play(AssetSource('audio/$phraseId.wav'), volume: 1);
      await done.future.timeout(const Duration(seconds: 15));
      await sub.cancel();
      return true;
    } catch (e) {
      lastError = '$e';
      if (kDebugMode) debugPrint('TTS speak error: $e');
      return false;
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (_) {}
  }
}
