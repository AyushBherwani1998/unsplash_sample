import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';
import 'package:unplash_sample/core/widgets/error_tile.dart';

void main() {
  const errorMessage = "test";
  final List<String> logs = [];

  Widget pumpErrorTileWidget() {
    return MaterialApp(
      home: Scaffold(
          body: ErrorTile(
        onTap: () {
          logs.add(errorMessage);
        },
        message: errorMessage,
      )),
    );
  }

  group("ErrorTile tests", () {
    testWidgets("text is displayed on screen", (tester) async {
      await tester.pumpWidget(pumpErrorTileWidget());

      expect(find.text(errorText), findsOneWidget);

      final errorMessageText = find.text(errorMessage);
      expect(errorMessageText, findsOneWidget);
    });

    testWidgets("onTap is called when tile is pressed", (tester) async {
      await tester.pumpWidget(pumpErrorTileWidget());

      expect(logs.isEmpty, isTrue);

      await tester.tap(find.byType(ErrorTile));
      await tester.pumpAndSettle();

      expect(logs.isEmpty, isFalse);
    });

    testWidgets("icon is displayed on screen", (tester) async {
      await tester.pumpWidget(pumpErrorTileWidget());

      expect(find.byIcon(CupertinoIcons.restart), findsOneWidget);
    });
  });
}
