import 'package:dartz/dartz.dart';
import 'package:unsplash_sample/core/error/error.dart';
import 'package:unsplash_sample/core/usecases/usecase.dart';
import 'package:unsplash_sample/features/image_details/domain/entities/image_details.dart';
import 'package:unsplash_sample/features/image_details/domain/repositories/image_details_repository.dart';

class FetchImageDetails extends Usecase<ImageDetails, String> {
  final ImageDetailsRepository imageDetailsRepository;

  FetchImageDetails(this.imageDetailsRepository);

  @override
  Future<Either<CustomError, ImageDetails>> call(String params) async {
    return imageDetailsRepository.fetchImageDetails(params);
  }
}
