import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'player_provider.g.dart';

@riverpod
class Player extends _$Player {
  @override
  Video? build() {
    return null;
  }

  void play(Video video) {
    state = video;
  }
}
