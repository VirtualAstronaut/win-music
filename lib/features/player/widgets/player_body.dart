import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';
import 'package:win_music/core/enums/enums.dart';
import 'package:win_music/features/player/provider/provider.dart';
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

class _PlayerUI extends StatelessWidget {
  const _PlayerUI({super.key, required this.video});
  final Video video;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.widthPx,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            video.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            video.author,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const _PlayerControls(),
        ],
      ),
    );
  }
}

class _PlayerControls extends ConsumerWidget {
  const _PlayerControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
}
