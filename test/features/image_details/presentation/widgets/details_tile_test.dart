import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_sample/features/image_details/data/models/image_details_model.dart';
import 'package:unsplash_sample/features/image_details/domain/entities/image_details.dart';
import 'package:unsplash_sample/features/image_details/presentation/widgets/details_tile.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  Widget pumpMaterialApp(ImageDetails imageDetails) {
    return MaterialApp(
      home: Scaffold(body: DetailsTile(imageDetails: imageDetails)),
    );
  }

  group("DetailsTile test", () {
    late final ImageDetails imageDetails;

    setUpAll(() {
      imageDetails = ImageDetailsModel.fromJson(
        Map<String, dynamic>.from(
          jsonDecode(fixture('image_details_fixture.json')) as Map,
        ),
      );
    });

    testWidgets("should display description", (tester) async {
      await tester.pumpWidget(pumpMaterialApp(imageDetails));

      expect(find.text(imageDetails.description), findsOneWidget);
    });

    testWidgets('should display no. of likes', (tester) async {
      await tester.pumpWidget(pumpMaterialApp(imageDetails));

      expect(find.text(imageDetails.likes.toString()), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.heart_fill), findsOneWidget);
    });
  });
}
