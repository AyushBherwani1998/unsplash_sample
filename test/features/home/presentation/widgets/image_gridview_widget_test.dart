import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unplash_sample/features/home/data/models/image_model.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_gridview_widget.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late final UnsplashImageListModel unsplashImageListModel;

  setUp(() {
    unsplashImageListModel =
        UnsplashImageListModel.fromJson(List<Map<String, dynamic>>.from(
      jsonDecode(fixture('image_model_fixture.json')),
    ));
  });

  testWidgets('GridView is rendered properly', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageGridViewWidget(images: unsplashImageListModel.images),
      ),
    ));

    expect(find.byType(SliverGrid), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
