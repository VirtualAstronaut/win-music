import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final ytClientProvider = Provider<YoutubeExplode>((ref) {
  final ytClient = YoutubeExplode();
  ref.onDispose(() {
    ytClient.close();
  });
  return ytClient;
});
