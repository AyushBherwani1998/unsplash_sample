import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unsplash_sample/core/error/error.dart';
import 'package:unsplash_sample/core/utils/string_constants.dart';
import 'package:unsplash_sample/features/home/data/models/image_model.dart';
import 'package:unsplash_sample/features/home/domain/entities/image.dart';
import 'package:unsplash_sample/features/home/domain/usecases/fetch_images.dart';
import 'package:unsplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';

import '../../../../core/mocks/fetch_images_mock.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late final FetchImagesMock fetchImagesMock;
  late final FetchImageParams params;
  late final FetchImageParams paginatedParams;
  late final List<UnsplashImage> images;

  group("UnsplashImageBloc test", () {
    setUpAll(() {
      fetchImagesMock = FetchImagesMock();
      params = FetchImageParams(1, 20);
      paginatedParams = FetchImageParams(2, 20);

      images = UnsplashImageListModel.fromJson(List<Map<String, dynamic>>.from(
        jsonDecode(fixture("image_model_fixture.json")) as List,
      )).images;

      registerFallbackValue(FakeFetchImageParams());
    });

    test("Initial state should be UnsplashImageInitialState", () {
      expect(
        UnsplashImageBloc(fetchImagesMock).state,
        UnsplashImageInitialState(),
      );
    });

    blocTest<UnsplashImageBloc, UnsplashImageState>(
      "Emits [UnsplashImageLoadingState, UnsplashImageErrroState] on error",
      build: () {
        when(() => fetchImagesMock.call(any())).thenAnswer((_) async {
          return Left(ServerError());
        });
        return UnsplashImageBloc(fetchImagesMock);
      },
      act: (bloc) => bloc.add(FetchImageEvent(params)),
      expect: () => [
        UnsplashImageLoadingState(),
        const UnsplashImageErrorState(serverErrorMessage),
      ],
    );

    blocTest<UnsplashImageBloc, UnsplashImageState>(
      "Emits [UnsplashImageLoadingState, UnsplashImageLoadedState] on success",
      build: () {
        when(() => fetchImagesMock.call(any())).thenAnswer((invocation) async {
          return Right(images);
        });
        return UnsplashImageBloc(fetchImagesMock);
      },
      act: (bloc) => bloc.add(FetchImageEvent(params)),
      expect: () => [
        UnsplashImageLoadingState(),
        UnsplashImageLoadedState(images, 1),
      ],
    );

    blocTest<UnsplashImageBloc, UnsplashImageState>(
      "Emits [UnsplashImagePaginatedLoadingState, UnsplashImageLoadedState] on pagination success",
      build: () {
        when(() => fetchImagesMock.call(any())).thenAnswer((invocation) async {
          return Right(images);
        });
        return UnsplashImageBloc(fetchImagesMock);
      },
      seed: () => UnsplashImageLoadedState(images, 1),
      act: (bloc) => bloc.add(FetchImageEvent(paginatedParams)),
      expect: () {
        final paginationResult = List<UnsplashImage>.from(
          images,
        );
        paginationResult.addAll(images);
        return [
          UnsplashImagePaginatedLoadingState(),
          UnsplashImageLoadedState(paginationResult, 2)
        ];
      },
    );

    blocTest<UnsplashImageBloc, UnsplashImageState>(
      'Emits [UnsplashImagePaginatedLoadingState, UnsplashImagePaginatedErrorState] on pagination error',
      build: () {
        when(() => fetchImagesMock.call(any())).thenAnswer((_) async {
          return Left(ServerError());
        });
        return UnsplashImageBloc(fetchImagesMock);
      },
      seed: () => UnsplashImageLoadedState(images, 1),
      act: (bloc) => bloc.add(FetchImageEvent(paginatedParams)),
      expect: () => [
        UnsplashImagePaginatedLoadingState(),
        const UnsplashImagePaginatedErrorState(serverErrorMessage),
      ],
    );
  });
}
