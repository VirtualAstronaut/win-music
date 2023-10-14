import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:win_music/features/player/provider/provider.dart';
import 'package:win_music/shared/widgets/loader.dart';
import 'package:win_music/shared/widgets/themed_icon_button.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'package:win_music/core/theme/padding.dart';
import 'package:win_music/features/search/provider/provider.dart';

/// {@template search_body}
/// Body of the SearchPage.
///
/// Add what it does
/// {@endtemplate}
class SearchBody extends StatelessWidget {
  /// {@macro search_body}
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: largePadding,
        top: largePadding,
        right: largePadding,
        bottom: largePadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: _SearchBar(),
          ),
          Flexible(
            flex: 10,
            child: _SearchData(),
          ),
        ],
      ),
    );
  }
}

class _SearchData extends ConsumerWidget {
  const _SearchData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(searchNotifierProvider);
    return searchProvider.when(
      data: (data) {
        return _ListData(
          data: data,
        );
      },
      error: (error, stackTrace) {
        log('$error');
        return ErrorWidget.withDetails(
          message: error.toString(),
        );
      },
      loading: () => const Loader(),
    );
  }
}

class _ListData extends StatelessWidget {
  const _ListData({
    super.key,
    required this.data,
  });
  final List<Video> data;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: data.length,
        padding: const EdgeInsets.only(
          top: mediumpadding,
          bottom: mediumpadding,
        ),
        itemBuilder: (context, index) {
          return _ListTile(
            video: data[index],
          );
        },
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({super.key, required this.video});
  final Video video;
  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
    side: BorderSide(
      color: Colors.black,
      width: 1,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: _shape,
      hoverColor: Colors.black12,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PlayButton(video: video),
          _QueueButton(video: video),
        ],
      ),
      onTap: () {},
      title: Text(
        video.title,
      ),
      subtitle: Text(
        durationString(
          video.duration,
        ),
      ),
    );
  }

  String durationString(Duration? duration) {
    //TODO: add formmater
    if (duration == null) return '';
    if (duration.inSeconds <= 60) return '${duration.inSeconds}';
    return '${duration.inMinutes}:${duration.inSeconds}';
  }
}

class _QueueButton extends ConsumerWidget {
  const _QueueButton({
    super.key,
    required this.video,
  });
  final Video video;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemedIconButton(
      onPressed: () => onQueue(ref),
      icon: const Icon(
        Icons.queue_music,
      ),
    );
  }

  void onQueue(
    WidgetRef ref,
  ) {
    final notifier = ref.read(playerProvider.notifier);
    notifier.queue(video);
  }
}

class _PlayButton extends ConsumerWidget {
  const _PlayButton({
    super.key,
    required this.video,
  });
  final Video video;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemedIconButton(
      onPressed: () => onPlay(ref),
      icon: const Icon(
        Icons.play_arrow_outlined,
      ),
    );
  }

  void onPlay(WidgetRef ref) {
    final playerNotifier = ref.read(playerProvider.notifier);
    playerNotifier.play(video);
  }
}

class _SearchBar extends ConsumerWidget {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = useTextEditingController();

    return Row(
      children: [
        ThemedIconButton(
          onPressed: () => popScreen(context),
          icon: const Icon(
            Icons.keyboard_double_arrow_left_outlined,
          ),
        ),
        const Expanded(
          child: _TextField(),
        ),
      ],
    );
  }

  void popScreen(BuildContext context) {
    Navigator.pop(context);
  }
}

class _TextField extends ConsumerWidget {
  const _TextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextFormField(
        onChanged: (value) => onChanged(ref, value),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
          ),
        ),
      ),
    );
  }

  void onChanged(WidgetRef ref, String value) {
    if (value.length < 3) return;
    final notifier = ref.read(searchNotifierProvider.notifier);
    notifier.search(value);
  }
}
