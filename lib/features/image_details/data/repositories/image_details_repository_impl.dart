import 'package:dartz/dartz.dart';
import 'package:unplash_sample/core/error/error.dart';
import 'package:unplash_sample/features/image_details/data/datasources/image_details_remote_datasource.dart';
import 'package:unplash_sample/features/image_details/domain/entities/image_details.dart';
import 'package:unplash_sample/features/image_details/domain/repositories/image_details_repository.dart';

class ImageDetailsRepositoryIml implements ImageDetailsRepository {
  final ImageDetailsRemoteDataSource remoteDataSource;

  ImageDetailsRepositoryIml(this.remoteDataSource);

  @override
  Future<Either<CustomError, ImageDetails>> fetchImageDetails(String id) async {
    try {
      final details = await remoteDataSource.fetchImageDetails(id);
      return Right(details);
    } on Exception {
      return Left(ServerError());
    }
  }
}
