import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';
import 'package:win_music/core/enums/enums.dart';
import 'package:win_music/features/player/provider/provider.dart';
import 'package:win_music/core/providers/core_providers.dart';
import 'package:win_music/features/search/search.dart';
import 'package:win_music/shared/widgets/widgets.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// {@template player_body}
/// Body of the PlayerPage.
///
/// Add what it does
/// {@endtemplate}
class PlayerBody extends ConsumerWidget {
  /// {@macro player_body}
  const PlayerBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerDetails = ref.watch(playerProvider);
    if (playerDetails.playerstate == WinPlayerState.empty) {
      return const _EmptyUi();
    }
    return _PlayerUI(
      video: playerDetails.video as Video,
    );
  }
}

class _EmptyUi extends StatelessWidget {
  const _EmptyUi({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Search something to play'),
    );
  }
}

class _PlayerUI extends ConsumerWidget {
  const _PlayerUI({super.key, required this.video});
  final Video video;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(positionProvider).value ?? Duration.zero;
    final duration = video.duration ?? Duration.zero;

    final details = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          video.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          video.author,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Slider(
          value: position.inSeconds.clamp(0, duration.inSeconds).toDouble(),
          max: duration.inSeconds.toDouble() == 0 ? 1 : duration.inSeconds.toDouble(),
          onChanged: (value) {
            ref.read(audioPlayerProvider).seek(Duration(seconds: value.toInt()));
          },
        ),
        const _PlayerControls(),
      ],
    );

    final thumbnail = Image.network(
      video.thumbnails.standardResUrl,
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        if (isWide) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Center(child: thumbnail)),
              Expanded(child: details),
            ],
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            thumbnail,
            details,
          ],
        );
      },
    );
  }
}

class _PlayerControls extends ConsumerWidget {
  const _PlayerControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final isPlaying = player.state == PlayerState.playing;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemedIconButton(
          onPressed: () => togglePlay(ref, isPlaying),
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        ),
        ThemedIconButton(
          onPressed: () => onNext(ref),
          icon: const Icon(
            Icons.skip_next_outlined,
          ),
        )
      ],
    );
  }

  void onNext(WidgetRef ref) {
    final notifier = ref.read(playerProvider.notifier);
    notifier.playNext();
  }

  void togglePlay(WidgetRef ref, bool isPlaying) {
    final player = ref.read(audioPlayerProvider);
    if (isPlaying) {
      player.pause();
    } else {
      player.resume();
    }
  }
}
