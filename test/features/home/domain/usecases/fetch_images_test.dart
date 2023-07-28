import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';
import 'package:unplash_sample/features/home/domain/repositories/unsplash_repository.dart';
import 'package:unplash_sample/features/home/domain/usecases/fetch_images.dart';

import '../../../../core/mocks/unsplash_repository_mock.dart';


void main() {
  late final FetchImages fetchImages;
  late final UnsplashRepository unsplashRepository;

  const String id = "id";
  const String url = "url";

  const imageListResponse = [
    UnsplashImage(
      id: id,
      url: url,
    )
  ];

  setUp(() {
    unsplashRepository = UnsplashRepositoryMock();
    fetchImages = FetchImages(repository: unsplashRepository);
  });

  test("fetchs images from unsplash repository", () async {
    when(() => unsplashRepository.fetchImages(any())).thenAnswer((_) async {
      return const Right(imageListResponse);
    });

    final images = await fetchImages.call(FetchImageParams(1, 10));

    expect(images.isRight(), true);
    expect(images, const Right(imageListResponse));
    verify(() => unsplashRepository.fetchImages(any())).called(1);
  });
}
