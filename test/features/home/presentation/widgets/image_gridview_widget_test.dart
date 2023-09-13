import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unsplash_sample/core/config/unleash_config.dart';
import 'package:unsplash_sample/features/home/data/models/image_model.dart';
import 'package:unsplash_sample/features/home/presentation/widgets/image_gridview_widget.dart';
import 'package:unsplash_sample/features/home/presentation/widgets/image_tile.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../service_locator_mock.dart';

void main() {
  late final UnsplashImageListModel unsplashImageListModel;
  late final UnleashConfig unleashConfig;

  setUp(() {
    SerivceLocatorMock.initialize();
    unleashConfig = SerivceLocatorMock.getIt<UnleashConfig>();
    unsplashImageListModel =
        UnsplashImageListModel.fromJson(List<Map<String, dynamic>>.from(
      jsonDecode(fixture('image_model_fixture.json')) as List,
    ));
  });

  testWidgets('GridView is rendered properly', (tester) async {
    when(() => unleashConfig.isLikeOptionExperimentEnabled).thenReturn(true);
    when(() => unleashConfig.likeButtonPosition)
        .thenReturn(LikeButtonPosition.gridTile);
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ImageGridViewWidget(
            images: unsplashImageListModel.images,
            controller: ScrollController(),
          ),
        ),
      ));

      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pump();

      expect(find.byType(SliverMasonryGrid), findsOneWidget);
      expect(find.byType(ImageTile), findsOneWidget);
    });
  });
}
