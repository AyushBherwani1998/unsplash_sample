import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unplash_sample/features/home/data/models/image_model.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_tile_header.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../mock_dependency_injection.dart';

void main() {
  late final UnsplashImage image;

  setUp(() {
    MockDependencyInjection.initialize();
    image = UnsplashImageListModel.fromJson(List<Map<String, dynamic>>.from(
      jsonDecode(fixture('image_model_fixture.json')) as List,
    )).images.first;
  });

  testWidgets('ImageTileHeader is rendered properly', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ImageTileHeader(
            image: image,
          ),
        ),
      ));

      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pump();

      expect(
        find.byWidgetPredicate(
            (widget) => widget is Container && widget.decoration != null),
        findsOneWidget,
      );
      expect(find.text(image.userName), findsOneWidget);
    });
  });
}
