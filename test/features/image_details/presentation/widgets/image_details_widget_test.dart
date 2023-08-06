import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unplash_sample/features/image_details/data/models/image_details_model.dart';
import 'package:unplash_sample/features/image_details/domain/entities/image_details.dart';
import 'package:unplash_sample/features/image_details/presentation/widgets/details_tile.dart';
import 'package:unplash_sample/features/image_details/presentation/widgets/image_details_widget.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  Widget pumpImageDetailsWidget(ImageDetails imageDetails) {
    return MaterialApp(
      home: Scaffold(body: ImageDetailsWidget(imageDetails: imageDetails)),
    );
  }

  group("ImageDetailsWidget tests", () {
    late final ImageDetails imageDetails;

    setUpAll(() {
      imageDetails = ImageDetailsModel.fromJson(
        jsonDecode(fixture('image_details_fixture.json')),
      );
    });

    testWidgets('should display image', (tester) async {
      await tester.pumpWidget(pumpImageDetailsWidget(imageDetails));
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('show display details tile', (tester) async {
      await tester.pumpWidget(pumpImageDetailsWidget(imageDetails));
      expect(find.byType(DetailsTile), findsOneWidget);
    });
  });
}
