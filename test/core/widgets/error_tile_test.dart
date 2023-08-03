import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unplash_sample/core/widgets/error_tile.dart';

void main() {

  group("ErrorTile tests", () {
    const text = "test";
    testWidgets("text is displayed on screen", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorTile(onTap: () {}, message: text),
          ),
        ),
      );

      final errorText = find.text(text);
      expect(errorText, findsOneWidget);
    });
  });
}
