import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'queue_provider.g.dart';

@Riverpod(keepAlive: true)
class Queue extends _$Queue {
  @override
  List<Video> build() {
    return [];
  }

  void add(Video video) {
    if (state.contains(video)) return;
    state = [...state, video];
  }
}
