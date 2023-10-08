import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:win_music/core/providers/yt_provider/yt_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'search_provider.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  Future<void> search(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final client = ref.watch(ytClientProvider);
      final result = await client.search.search(query);
      return result;
    });
  }

  @override
  FutureOr<List<Video>> build() async {
    return [];
  }
}
