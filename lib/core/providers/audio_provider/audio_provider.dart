import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:win_music/features/player/player.dart';
import 'package:audioplayers/audioplayers.dart';

final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  ref.onDispose(player.dispose);
  _playerCompleteListener(player, ref);
  return player;
});

final positionProvider = StreamProvider<Duration>((ref) {
  final player = ref.watch(audioPlayerProvider);
  return player.onPositionChanged;
});

void _playerCompleteListener(AudioPlayer player, Ref ref) {
  player.onPlayerComplete.listen((event) {
    log('Player Complete Called');
    final notifier = ref.read(playerProvider.notifier);
    notifier.playNext();
  });
}
