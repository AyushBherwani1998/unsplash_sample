import 'package:dartz/dartz.dart';
import 'package:unsplash_sample/core/error/error.dart';
import 'package:unsplash_sample/features/home/data/datasources/unsplash_remote_datasource.dart';
import 'package:unsplash_sample/features/home/domain/entities/image.dart';
import 'package:unsplash_sample/features/home/domain/repositories/unsplash_repository.dart';

class UnsplashRepositoryImpl implements UnsplashRepository {
  final UnsplashRemoteDataSource remoteDataSource;

  UnsplashRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<CustomError, List<UnsplashImage>>> fetchImages(
    int pageNumber,
    int perPage,
  ) async {
    try {
      return Right(await remoteDataSource.fetchImages(pageNumber, perPage));
    } on Exception {
      return Left(ServerError());
    }
  }
}
