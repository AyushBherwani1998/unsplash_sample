import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';
import 'package:unplash_sample/core/widgets/error_tile.dart';
import 'package:unplash_sample/core/widgets/like_button.dart';
import 'package:unplash_sample/features/image_details/data/models/image_details_model.dart';
import 'package:unplash_sample/features/image_details/presentation/bloc/image_details_bloc.dart';
import 'package:unplash_sample/features/image_details/presentation/pages/image_details_page.dart';
import 'package:unplash_sample/features/image_details/presentation/widgets/image_details_widget.dart';

import '../../../../core/mocks/image_details_bloc_mock.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../mock_dependency_injection.dart';

void main() {
  Widget pumpMaterialApp(Widget home) {
    return MaterialApp(
      home: home,
    );
  }

  group("ImageDetailsPage tests", () {
    late final ImageDetailsBloc bloc;
    late final UnleashConfig unleashConfig;

    setUpAll(() {
      bloc = ImageDetailsBlocMock();
      MockDependencyInjection.initialize(imageDetailsBloc: bloc);
      unleashConfig = MockDependencyInjection.getIt<UnleashConfig>();
      when(() => unleashConfig.isLikeOptionExperimentEnabled).thenReturn(true);
      when(() => unleashConfig.likeButtonPosition)
          .thenReturn(LikeButtonPosition.imageDetails);
    });

    tearDownAll(() {
      MockDependencyInjection.getIt.reset();
    });

    testWidgets("should show ErrorTile on ImageDetailsErrorState",
        (tester) async {
      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(const ImageDetailsErrorState(serverErrorMessage));
      });

      when(() => bloc.state).thenReturn(
        const ImageDetailsErrorState(serverErrorMessage),
      );

      await tester.pumpWidget(
        pumpMaterialApp(const ImageDetailsPage(id: "id")),
      );

      await tester.tap(find.byType(ErrorTile));
      await tester.pumpAndSettle();

      expect(find.byType(ErrorTile), findsOneWidget);
      expect(find.text(serverErrorMessage), findsOneWidget);
    });

    testWidgets(
        "should show CircularProgressIndicator on ImageDetailsLoadingState",
        (tester) async {
      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(ImageDetailsLoadingState());
      });

      when(() => bloc.state).thenReturn(ImageDetailsLoadingState());

      await tester.pumpWidget(
        pumpMaterialApp(const ImageDetailsPage(id: "id")),
      );

      final progressIndicator = find.byType(CircularProgressIndicator);

      expect(progressIndicator, findsOneWidget);
    });

    testWidgets(
        "should show CircularProgressIndicator on ImageDetailsInitialState",
        (tester) async {
      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(ImageDetailsInitialState());
      });

      when(() => bloc.state).thenReturn(ImageDetailsInitialState());

      await tester
          .pumpWidget(pumpMaterialApp(const ImageDetailsPage(id: "id")));

      final progressIndicator = find.byType(CircularProgressIndicator);

      expect(progressIndicator, findsOneWidget);
    });

    testWidgets("should show ImageDetailsWidget on ImageDetailsLoadedState",
        (tester) async {
      final imageDetails = ImageDetailsModel.fromJson(
        Map<String, dynamic>.from(
          jsonDecode(fixture('image_details_fixture.json')) as Map,
        ),
      );

      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(ImageDetailsLoadedState(imageDetails));
      });

      when(() => bloc.state).thenReturn(ImageDetailsLoadedState(imageDetails));

      await tester.pumpWidget(pumpMaterialApp(
        const ImageDetailsPage(id: "id"),
      ));

      final imageGridView = find.byType(ImageDetailsWidget);

      expect(imageGridView, findsOneWidget);
      expect(find.byType(LikeButton), findsOneWidget);
    });

    testWidgets('should close page on clicking x-mark icon', (tester) async {
      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(ImageDetailsLoadingState());
      });

      when(() => bloc.state).thenReturn(ImageDetailsLoadingState());

      await tester.pumpWidget(
        pumpMaterialApp(const ImageDetailsPage(id: "id")),
      );

      expect(find.byIcon(CupertinoIcons.xmark), findsOneWidget);

      await tester.tap(find.byIcon(CupertinoIcons.xmark));
      await tester.pumpAndSettle();

      expect(find.byIcon(CupertinoIcons.xmark), findsNothing);
    });
  });
}
