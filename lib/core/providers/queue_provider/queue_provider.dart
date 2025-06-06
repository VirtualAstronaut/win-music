import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class QueueNotifier extends StateNotifier<List<Video>> {
  QueueNotifier() : super([]);

  void add(Video video) {
    if (state.contains(video)) return;
    state = [...state, video];
  }
}

final queueProvider =
    StateNotifierProvider<QueueNotifier, List<Video>>((ref) => QueueNotifier());
