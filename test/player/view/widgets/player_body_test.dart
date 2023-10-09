// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:win_music/features/player/player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayerBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        MaterialApp(home: PlayerBody()),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
