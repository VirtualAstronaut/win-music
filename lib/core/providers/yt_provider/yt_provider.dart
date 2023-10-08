import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
part 'yt_provider.g.dart';

@riverpod
YoutubeExplode ytClient(YtClientRef ref) {
  final ytClient = YoutubeExplode();

  ref.onDispose(() {
    ytClient.close();
  });
  return ytClient;
}
