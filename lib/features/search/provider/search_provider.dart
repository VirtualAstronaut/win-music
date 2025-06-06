import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:win_music/core/providers/yt_provider/yt_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchNotifier extends StateNotifier<AsyncValue<List<Video>>> {
  SearchNotifier(this.ref) : super(const AsyncValue.data([]));

  final Ref ref;

  Future<void> search(String query) async {
    state = const AsyncValue.loading();
    final client = ref.read(ytClientProvider);
    final result = await client.search.search(query);
    state = AsyncValue.data(result);
  }
}

final searchNotifierProvider = StateNotifierProvider<SearchNotifier,
    AsyncValue<List<Video>>>((ref) => SearchNotifier(ref));
