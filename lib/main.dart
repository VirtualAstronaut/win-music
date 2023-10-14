import 'package:flutter/material.dart';
import 'package:win_music/core/theme/theme_data.dart';
import 'package:win_music/shared/logger/provider_logger.dart';

import 'features/player/player.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const PlayerPage(),
          theme: ref.watch(defaultThemeProvider),
        );
      },
    );
  }
}
