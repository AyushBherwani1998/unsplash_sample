import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unsplash_sample/core/error/error.dart';
import 'package:unsplash_sample/features/home/data/datasources/unsplash_remote_datasource.dart';
import 'package:unsplash_sample/features/home/data/models/image_model.dart';
import 'package:unsplash_sample/features/home/data/repositories/unsplash_repository_impl.dart';

import '../../../../core/mocks/unsplash_remote_datasource_mock.dart';

void main() {
  group("Unsplash repository implementation tests", () {
    late final UnsplashRemoteDataSource remoteDataSourceMock;
    late final UnsplashRepositoryImpl unsplashRepositoryImpl;
    const unsplashImage = UnsplashImageModel(
      id: "id",
      url: "url",
      blurHash: "blurHash",
      likes: 1,
      profileImage: "profileImage",
      userName: "userName",
    );

    setUpAll(() {
      remoteDataSourceMock = UnsplashRemoteDataSourceMock();
      unsplashRepositoryImpl = UnsplashRepositoryImpl(remoteDataSourceMock);
    });

    test('Returns UnsplashImage list upon success', () async {
      when(() => remoteDataSourceMock.fetchImages(any(), any())).thenAnswer(
        (_) async {
          return [unsplashImage];
        },
      );

      final images = await unsplashRepositoryImpl.fetchImages(1, 10);

      images.fold(
        (left) => expect(left, isNull),
        (right) => expect(right, [unsplashImage]),
      );
    });

    test('Returns ServerError upon exception', () async {
      when(() => remoteDataSourceMock.fetchImages(any(), any()))
          .thenThrow(Exception());

      final images = await unsplashRepositoryImpl.fetchImages(1, 10);

      images.fold(
        (left) => expect(left, ServerError()),
        (right) => expect(right, isNull),
      );
    });
  });
}
