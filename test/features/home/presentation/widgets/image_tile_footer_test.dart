import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unplash_sample/features/home/data/models/image_model.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_tile_footer.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late final UnsplashImage image;

  setUpAll(() {
    image = UnsplashImageListModel.fromJson(List<Map<String, dynamic>>.from(
      jsonDecode(fixture('image_model_fixture.json')) as List,
    )).images.first;
  });

  Widget pumpImageTileFooterWidget() {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(child: ImageTileFooter(image: image)),
      ),
    );
  }

  group('ImageTileFooter test', () {
    testWidgets('should render IconButton and Text', (tester) async {
      await tester.pumpWidget(pumpImageTileFooterWidget());

      expect(find.byIcon(CupertinoIcons.heart), findsOneWidget);
      expect(find.text(image.likes.toString()), findsOneWidget);
    });
  });
}
