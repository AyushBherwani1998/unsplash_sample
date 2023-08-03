import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unplash_sample/core/widgets/error_tile.dart';

void main() {
  const text = "test";
  final List<String> logs = [];

  Widget pumpErrorTileWidget() {
    return MaterialApp(
      home: Scaffold(
          body: ErrorTile(
        onTap: () {
          logs.add(text);
        },
        message: text,
      )),
    );
  }

  group("ErrorTile tests", () {
    testWidgets("text is displayed on screen", (tester) async {
      await tester.pumpWidget(pumpErrorTileWidget());

      final errorText = find.text(text);
      expect(errorText, findsOneWidget);
    });

    testWidgets("onTap is called when tile is pressed", (tester) async {
      await tester.pumpWidget(pumpErrorTileWidget());

      expect(logs.isEmpty, isTrue);

      await tester.tap(find.byType(ErrorTile));
      await tester.pumpAndSettle();

      expect(logs.isEmpty, isFalse);
    });
  });
}
