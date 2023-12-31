import 'package:dartz/dartz.dart';
import 'package:unsplash_sample/core/error/error.dart';
import 'package:unsplash_sample/features/home/domain/entities/image.dart';

abstract class UnsplashRepository {
  Future<Either<CustomError, List<UnsplashImage>>> fetchImages(
    int pageNumber,
    int perPage,
  );
}
