import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/error/error.dart';
import 'package:unplash_sample/features/home/data/datasources/unsplash_remote_datasource.dart';
import 'package:unplash_sample/features/home/data/repositories/unsplash_repository_impl.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';

import '../../../../core/mocks/unsplash_remote_datasource_mock.dart';

void main() {
  group("Unsplash repository implementation tests", () {
    late final UnsplashRemoteDataSource remoteDataSourceMock;
    late final UnsplashRepositoryImpl unsplashRepositoryImpl;
    const UnsplashImage unsplashImage = UnsplashImage(id: "id", url: "url");

    setUpAll(() {
      remoteDataSourceMock = UnsplashRemoteDataSourceMock();
      unsplashRepositoryImpl = UnsplashRepositoryImpl(remoteDataSourceMock);
    });

    test('Returns UnsplashImage list upon success', () async {
      when(() => remoteDataSourceMock.fetchImages(any())).thenAnswer(
        (_) async {
          return [unsplashImage];
        },
      );

      final images = await unsplashRepositoryImpl.fetchImages(1);

      images.fold(
        (left) => expect(left, isNull),
        (right) => expect(right, [unsplashImage]),
      );
    });

    test('Returns ServerError upon exception', () async {
      when(() => remoteDataSourceMock.fetchImages(any()))
          .thenThrow(Exception());

      final images = await unsplashRepositoryImpl.fetchImages(1);

      images.fold(
        (left) => expect(left, ServerError()),
        (right) => expect(right, isNull),
      );
    });
  });
}
