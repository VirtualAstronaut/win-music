import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:audioplayers/audioplayers.dart';

part 'audio_provider.g.dart';

@riverpod
AudioPlayer audioPlayer(AudioPlayerRef ref) {
  final player = AudioPlayer();

  ref.onDispose(() {
    player.dispose();
  });
  return player;
}
