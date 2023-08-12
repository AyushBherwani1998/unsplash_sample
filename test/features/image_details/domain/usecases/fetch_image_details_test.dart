import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/error/error.dart';
import 'package:unplash_sample/features/image_details/domain/entities/image_details.dart';
import 'package:unplash_sample/features/image_details/domain/repositories/image_details_repository.dart';
import 'package:unplash_sample/features/image_details/domain/usecases/fetch_image_details.dart';

import '../../../../core/mocks/image_details_repository_mock.dart';

void main() {
  late final ImageDetailsRepository repository;
  late final FetchImageDetails fetchImageDetails;
  late final ImageDetails imageDetails;

  setUp(() {
    repository = ImageDetailsRepositoryMock();
    fetchImageDetails = FetchImageDetails(repository);
    imageDetails = const ImageDetails(
      url: "url",
      description: "description",
      downloads: 1,
      likes: 1,
    );
  });

  test("fetchs image details from repository", () async {
    when(() => repository.fetchImageDetails(any()))
        .thenAnswer((invocation) async {
      return Right(imageDetails);
    });

    final result = await fetchImageDetails("12");

    verify(() => repository.fetchImageDetails(any())).called(1);

    expect(result, Right<CustomError, ImageDetails>(imageDetails));
  });
}
