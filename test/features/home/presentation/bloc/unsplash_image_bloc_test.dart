import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/error/error.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';
import 'package:unplash_sample/features/home/data/models/image_model.dart';
import 'package:unplash_sample/features/home/domain/usecases/fetch_images.dart';
import 'package:unplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';

import '../../../../core/mocks/fetch_images_mock.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late final FetchImagesMock fetchImagesMock;
  late final Bloc bloc;
  late final FetchImageParams params;

  group("UnsplashImageBloc test", () {
    setUpAll(() {
      fetchImagesMock = FetchImagesMock();
      bloc = UnsplashImageBloc(fetchImagesMock);
      params = FetchImageParams(1, 20);

      registerFallbackValue(FakeFetchImageParams());
    });

    test("Initial state should be UnsplashImageInitialState", () {
      expect(bloc.state, UnsplashImageInitialState());
    });

    test(
      "Emits [UnsplashImageLoadingState, UnsplashImageErrroState] on error",
      () {
        when(() => fetchImagesMock.call(any())).thenAnswer((invocation) async {
          return Left(ServerError());
        });

        bloc.add(FetchImageEvent(params));

        expectLater(
          bloc.stream,
          emitsInOrder([
            UnsplashImageLoadingState(),
            const UnsplashImageErrorState(serverErrorMessage),
          ]),
        );
      },
    );

    test(
      "Emits [UnsplashImageLoadingState, UnsplashImageLoadedState] on success",
      () {
        final imageListModel =
            UnsplashImageListModel.fromJson(List<Map<String, dynamic>>.from(
          jsonDecode(fixture("image_model_fixture.json")),
        ));

        when(() => fetchImagesMock.call(any())).thenAnswer((invocation) async {
          return Right(imageListModel.images);
        });

        bloc.add(FetchImageEvent(params));

        expectLater(
          bloc.stream,
          emitsInOrder([
            UnsplashImageLoadingState(),
            UnsplashImageLoadedState(imageListModel.images),
          ]),
        );
      },
    );
  });
}
