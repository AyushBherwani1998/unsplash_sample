import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/features/home/data/models/image_model.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_tile.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_tile_footer.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_tile_header.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../mock_dependency_injection.dart';

void main() {
  late final UnsplashImageListModel unsplashImageListModel;
  late final UnleashConfig unleashConfig;

  setUpAll(() {
    MockDependencyInjection.initialize();
    unleashConfig = MockDependencyInjection.getIt<UnleashConfig>();
    unsplashImageListModel =
        UnsplashImageListModel.fromJson(List<Map<String, dynamic>>.from(
      jsonDecode(fixture('image_model_fixture.json')) as List,
    ));
  });

  Widget pumpImageTile() {
    return MaterialApp(
      home: Scaffold(
        body: ImageTile(
          image: unsplashImageListModel.images.first,
          unleashConfig: unleashConfig,
        ),
      ),
    );
  }

  group('ImageTile test', () {
    testWidgets('should render ImageTile properly', (tester) async {
      when(() => unleashConfig.isLikeOptionExperimentEnabled).thenReturn(true);
      when(() => unleashConfig.likeButtonPosition)
          .thenReturn(LikeButtonPosition.gridTile);

      await tester.runAsync(() async {
        await tester.pumpWidget(pumpImageTile());

        await Future<void>.delayed(const Duration(milliseconds: 1000));
        await tester.pump();

        expect(find.byType(ImageTileHeader), findsOneWidget);
        expect(find.byType(ImageTileFooter), findsOneWidget);
      });
    });

    testWidgets('should not render ImageTileFooter when variant is gridTile',
        (tester) async {
      when(() => unleashConfig.isLikeOptionExperimentEnabled).thenReturn(true);
      when(() => unleashConfig.likeButtonPosition)
          .thenReturn(LikeButtonPosition.imageDetails);

      await tester.runAsync(() async {
        await tester.pumpWidget(pumpImageTile());

        await Future<void>.delayed(const Duration(milliseconds: 1000));
        await tester.pump();

        expect(find.byType(ImageTileHeader), findsOneWidget);
        expect(find.byType(ImageTileFooter), findsNothing);
      });
    });
  });
}
