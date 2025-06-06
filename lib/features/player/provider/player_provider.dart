import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:win_music/core/enums/enums.dart';
import 'package:win_music/core/providers/core_providers.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayerStateData {
  PlayerStateData({required this.playerstate, this.video});
  final WinPlayerState playerstate;
  final Video? video;

  PlayerStateData copyWith({WinPlayerState? playerstate, Video? video}) {
    return PlayerStateData(
      playerstate: playerstate ?? this.playerstate,
      video: video ?? this.video,
    );
  }
}

class PlayerNotifier extends StateNotifier<PlayerStateData> {
  PlayerNotifier(this.ref)
      : super(PlayerStateData(playerstate: WinPlayerState.empty));

  final Ref ref;

  Future<void> play(Video video) async {
    final player = ref.read(audioPlayerProvider);
    final audioUri = await _getAudioUrl(video);
    queue(video);
    if (player.state == PlayerState.playing) {
      await player.stop();
    }
    await player.play(UrlSource(audioUri.toString()));
    state = state.copyWith(playerstate: WinPlayerState.playing, video: video);
  }

  void queue(Video video) {
    final notifier = ref.read(queueProvider.notifier);
    notifier.add(video);
  }

  void playNext() {
    if (!_canPlayNext()) return;

    final currentIndex = getCurrentIndex();
    final queue = ref.read(queueProvider);
    play(queue[currentIndex + 1]);
  }

  int getCurrentIndex() {
    final queue = ref.read(queueProvider);
    final video = state.video;
    final indexOfCurrent = queue.indexWhere((element) => element == video);
    return indexOfCurrent;
  }

  bool _canPlayNext() {
    if (!_validate()) return false;
    return true;
  }

  bool _validate() {
    final queue = ref.read(queueProvider);

    final isVideoNull = state.video == null;
    if (isVideoNull) return false;

    final isQueueSingle = queue.length == 1;
    if (isQueueSingle) return false;

    final currentIndex = getCurrentIndex();
    final isCurrentLast = currentIndex == queue.length - 1;
    if (isCurrentLast) return false;

    return true;
  }

  Future<Uri> _getAudioUrl(Video video) async {
    final yt = ref.read(ytClientProvider);
    final manifest = await yt.videos.streamsClient.getManifest(video.id);

    return manifest.audioOnly.withHighestBitrate().url;
  }
}

final playerProvider =
    StateNotifierProvider<PlayerNotifier, PlayerStateData>((ref) {
  return PlayerNotifier(ref);
});
