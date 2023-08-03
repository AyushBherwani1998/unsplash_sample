import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';
import 'package:unplash_sample/core/widgets/error_tile.dart';
import 'package:unplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';
import 'package:unplash_sample/features/home/presentation/pages/home_page.dart';

import '../../../../core/mocks/unsplash_image_bloc_mock.dart';
import '../../../../mock_dependency_injection.dart';

void main() {
  Widget pumpMaterialApp(Widget home) {
    return MaterialApp(
      home: home,
    );
  }

  group("HomePage tests", () {
    late final UnsplashImageBloc bloc;

    setUpAll(() {
      bloc = UnsplashImageBlocMock();
      MockDependencyInjection.initialize(bloc);
    });

    tearDownAll(() {
      MockDependencyInjection.getIt.reset();
    });

    testWidgets("should show ErrorTile on UnsplashImageErrorState",
        (WidgetTester tester) async {
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
        (WidgetTester tester) async {
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
        (WidgetTester tester) async {
      when(() => bloc.stream).thenAnswer((_) {
        return Stream.value(UnsplashImageInitialState());
      });

      when(() => bloc.state).thenReturn(UnsplashImageInitialState());

      await tester.pumpWidget(pumpMaterialApp(const HomePage()));

      final progressIndicator = find.byType(CircularProgressIndicator);

      expect(progressIndicator, findsOneWidget);
    });
  });
}
