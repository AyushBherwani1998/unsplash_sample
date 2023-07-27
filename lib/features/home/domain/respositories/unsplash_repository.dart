import 'package:dartz/dartz.dart';
import 'package:unplash_sample/core/error/error.dart';
import 'package:unplash_sample/features/home/domain/entities/image_list_response.dart';

abstract class UnsplashRepository {
  Future<Either<CustomError, ImageListResponse>> fetchImages(int pageNumber);
}
