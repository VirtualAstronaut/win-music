import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:win_music/features/player/player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:audioplayers/audioplayers.dart';

part 'audio_provider.g.dart';

@riverpod
AudioPlayer audioPlayer(AudioPlayerRef ref) {
  final player = AudioPlayer();

  ref.onDispose(() {
    player.dispose();
  });
  _playerCompleteListner(player, ref);
  return player;
}

void _playerCompleteListner(AudioPlayer player, AudioPlayerRef ref) {
  player.onPlayerComplete.listen((event) {
    log('Player Complete Called');
    final notifier = ref.read(playerProvider.notifier);
    notifier.playNext();
  });
}
