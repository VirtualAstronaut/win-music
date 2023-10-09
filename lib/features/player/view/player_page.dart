import 'package:flutter/material.dart';
import 'package:win_music/features/player/widgets/player_body.dart';
import 'package:win_music/features/search/search.dart';

/// {@template player_page}
/// A description for PlayerPage
/// {@endtemplate}
class PlayerPage extends StatelessWidget {
  /// {@macro player_page}
  const PlayerPage({super.key});

  /// The static route for PlayerPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PlayerPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PlayerView(),
    );
  }
}

/// {@template player_view}
/// Displays the Body of PlayerView
/// {@endtemplate}
class PlayerView extends StatelessWidget {
  /// {@macro player_view}
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => openSearch(context),
            icon: const Icon(
              Icons.search,
            ),
          ),
        ),
        const Expanded(child: PlayerBody()),
      ],
    );
  }

  void openSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const SearchPage();
        },
      ),
    );
  }
}
