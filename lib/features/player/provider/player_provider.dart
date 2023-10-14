import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:win_music/core/providers/audio_provider/audio_provider.dart';
import 'package:win_music/core/providers/yt_provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'player_provider.g.dart';

@riverpod
class Player extends _$Player {
  @override
  Video? build() {
    return null;
  }

  void play(Video video) async {
    final player = ref.watch(audioPlayerProvider);
    final audioUri = await _getAudioUrl(video);
    log(audioUri.toString());
    player.play(UrlSource(audioUri.toString()));
    state = video;
  }

  Future<Uri> _getAudioUrl(Video video) async {
    final yt = ref.watch(ytClientProvider);
    final manifest = await yt.videos.streamsClient.getManifest(video.id);

    return manifest.audioOnly.withHighestBitrate().url;
  }
}
