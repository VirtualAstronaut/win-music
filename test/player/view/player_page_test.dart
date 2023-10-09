// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:win_music/features/player/player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayerPage', () {
    group('route', () {
      test('is routable', () {
        expect(PlayerPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders PlayerView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: PlayerPage()));
      expect(find.byType(PlayerView), findsOneWidget);
    });
  });
}
