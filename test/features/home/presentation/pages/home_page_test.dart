import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unsplash_sample/core/config/unleash_config.dart';
import 'package:unsplash_sample/core/utils/string_constants.dart';
import 'package:unsplash_sample/core/widgets/error_tile.dart';
import 'package:unsplash_sample/features/home/data/models/image_model.dart';
import 'package:unsplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';
import 'package:unsplash_sample/features/home/presentation/pages/home_page.dart';
import 'package:unsplash_sample/features/home/presentation/widgets/image_gridview_widget.dart';

import '../../../../core/mocks/unsplash_image_bloc_mock.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../service_locator_mock.dart';

void main() {
  Widget pumpMaterialApp(Widget home) {
    return MaterialApp(
      home: home,
    );
  }

  group("HomePage tests", () {
    late final UnsplashImageBloc bloc;
    late final UnleashConfig unleashConfig;

    setUpAll(() {
      bloc = UnsplashImageBlocMock();
      SerivceLocatorMock.initialize(unsplashImageBloc: bloc);
      unleashConfig = SerivceLocatorMock.getIt<UnleashConfig>();

      when(() => unleashConfig.isLikeOptionExperimentEnabled).thenReturn(true);
      when(() => unleashConfig.likeButtonPosition)
          .thenReturn(LikeButtonPosition.gridTile);
    });

    tearDownAll(() {
      SerivceLocatorMock.getIt.reset();
    });

    testWidgets("should show ErrorTile on UnsplashImageErrorState",
        (tester) async {
      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(const UnsplashImageErrorState(serverErrorMessage));
      });

      when(() => bloc.state).thenReturn(
        const UnsplashImageErrorState(serverErrorMessage),
      );

      await tester.pumpWidget(pumpMaterialApp(const HomePage()));

      await tester.tap(find.byType(ErrorTile));
      await tester.pumpAndSettle();

      expect(find.byType(ErrorTile), findsOneWidget);
      expect(find.text(serverErrorMessage), findsOneWidget);
    });

    testWidgets(
        "should show CircularProgressIndicator on UnsplashImageLoadingState",
        (tester) async {
      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(UnsplashImageLoadingState());
      });

      when(() => bloc.state).thenReturn(UnsplashImageLoadingState());

      await tester.pumpWidget(pumpMaterialApp(const HomePage()));

      final progressIndicator = find.byType(CircularProgressIndicator);

      expect(progressIndicator, findsOneWidget);
    });

    testWidgets(
        "should show CircularProgressIndicator on UnsplashImageInitialState",
        (tester) async {
      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(UnsplashImageInitialState());
      });

      when(() => bloc.state).thenReturn(UnsplashImageInitialState());

      await tester.pumpWidget(pumpMaterialApp(const HomePage()));

      final progressIndicator = find.byType(CircularProgressIndicator);

      expect(progressIndicator, findsOneWidget);
    });

    testWidgets("should show ImageGridViewWidget on UnsplashImageLoadedState",
        (tester) async {
      final unsplashImageListModel = UnsplashImageListModel.fromJson(
        List<Map<String, dynamic>>.from(
          jsonDecode(fixture('image_model_fixture.json')) as List,
        ),
      );

      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(
          UnsplashImageLoadedState(unsplashImageListModel.images, 1),
        );
      });

      when(() => bloc.state).thenReturn(
        UnsplashImageLoadedState(unsplashImageListModel.images, 1),
      );

      await tester.pumpWidget(pumpMaterialApp(const HomePage()));

      final imageGridView = find.byType(ImageGridViewWidget);

      expect(imageGridView, findsOneWidget);
    });
  });
}
