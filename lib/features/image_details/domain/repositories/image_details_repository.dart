import 'package:dartz/dartz.dart';
import 'package:unsplash_sample/core/error/error.dart';
import 'package:unsplash_sample/features/image_details/domain/entities/image_details.dart';

abstract class ImageDetailsRepository {
  Future<Either<CustomError, ImageDetails>> fetchImageDetails(String id);
}
