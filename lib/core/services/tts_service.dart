import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
    HapticFeedback.mediumImpact();
    await init();

    Uint8List? bytes;
    try {
      final data = await rootBundle.load('assets/audio/$phraseId.wav');
      bytes = data.buffer.asUint8List();
      debugPrint('TTS loaded $phraseId ${bytes.lengthInBytes} bytes');
    } catch (e) {
      lastError = 'missing asset $phraseId: $e';
      debugPrint('TTS $lastError');
      return false;
    }

    try {
      await _player.stop();
      await _player.setVolume(1);
      if (slow) await _player.setPlaybackRate(0.78);
      else await _player.setPlaybackRate(1);
      final done = Completer<void>();
      final sub = _player.onPlayerComplete.listen((_) {
        if (!done.isCompleted) done.complete();
      });
      await _player.play(BytesSource(bytes, mimeType: 'audio/wav'), volume: 1);
      debugPrint('TTS playing $phraseId state=${_player.state}');
      await done.future.timeout(const Duration(seconds: 15));
      await sub.cancel();
      return true;
    } catch (e) {
      debugPrint('TTS bytes play: $e');
    }

    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$phraseId.wav');
      await file.writeAsBytes(bytes, flush: true);
      await _player.stop();
      final done = Completer<void>();
      final sub = _player.onPlayerComplete.listen((_) {
        if (!done.isCompleted) done.complete();
      });
      await _player.play(DeviceFileSource(file.path), volume: 1);
      await done.future.timeout(const Duration(seconds: 15));
      await sub.cancel();
      return true;
    } catch (e) {
      lastError = '$e';
      debugPrint('TTS speak error: $e');
      return false;
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (_) {}
  }
}
