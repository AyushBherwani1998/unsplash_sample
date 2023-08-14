import 'package:dartz/dartz.dart';
import 'package:unplash_sample/core/error/error.dart';
import 'package:unplash_sample/core/usecases/usecase.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';
import 'package:unplash_sample/features/home/domain/repositories/unsplash_repository.dart';

class FetchImages extends Usecase<List<UnsplashImage>, FetchImageParams> {
  final UnsplashRepository repository;

  FetchImages({required this.repository});

  @override
  Future<Either<CustomError, List<UnsplashImage>>> call(FetchImageParams params) async {
    return await repository.fetchImages(params.page, params.perPage);
  }
}

class FetchImageParams {
  final int page;
  final int perPage;

  FetchImageParams(this.page, this.perPage);
}
