package com.PhrasePalMNG.PhrasePal

import android.content.Context
import android.media.AudioAttributes
import android.media.AudioManager
import android.media.MediaPlayer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class PhraseTtsPlugin : FlutterPlugin {
    private var channel: MethodChannel? = null
    private var player: MediaPlayer? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val app = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "prepareAudio" -> result.success(prepareAudio(app))
                    "playFile" -> playFile(app, call.argument<String>("path").orEmpty(), result)
                    "stop" -> {
                        stopPlayer()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
        stopPlayer()
    }

    private fun playFile(context: Context, path: String, result: MethodChannel.Result) {
        if (path.isEmpty()) {
            result.success(false)
            return
        }
        prepareAudio(context)
        stopPlayer()
        try {
            var replied = false
            fun reply(ok: Boolean) {
                if (replied) return
                replied = true
                result.success(ok)
            }
            player = MediaPlayer().apply {
                setAudioAttributes(
                    AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_MEDIA)
                        .setContentType(AudioAttributes.CONTENT_TYPE_SPEECH)
                        .build(),
                )
                setVolume(1f, 1f)
                setDataSource(path)
                setOnCompletionListener {
                    stopPlayer()
                    reply(true)
                }
                setOnErrorListener { _, what, extra ->
                    android.util.Log.e("PhraseTts", "play error $what $extra")
                    stopPlayer()
                    reply(false)
                    true
                }
                prepare()
                start()
            }
        } catch (e: Exception) {
            android.util.Log.e("PhraseTts", "playFile", e)
            result.success(false)
        }
    }

    private fun stopPlayer() {
        try {
            player?.reset()
            player?.release()
        } catch (_: Exception) {
        }
        player = null
    }

    companion object {
        const val CHANNEL = "phrasepal/tts"

        fun prepareAudio(context: Context): Map<String, Int> {
            val audio = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
            audio.mode = AudioManager.MODE_NORMAL
            audio.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_UNMUTE, 0)
            val max = audio.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
            var vol = audio.getStreamVolume(AudioManager.STREAM_MUSIC)
            if (vol == 0 && max > 0) {
                vol = (max * 0.6f).toInt().coerceAtLeast(1)
                audio.setStreamVolume(AudioManager.STREAM_MUSIC, vol, AudioManager.FLAG_SHOW_UI)
            }
            return mapOf("volume" to vol, "max" to max)
        }
    }
}
