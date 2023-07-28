import 'package:dartz/dartz.dart';
import 'package:unplash_sample/core/error/error.dart';
import 'package:unplash_sample/core/usecases/usecase.dart';
import 'package:unplash_sample/features/home/domain/entities/image_list_response.dart';
import 'package:unplash_sample/features/home/domain/respositories/unsplash_repository.dart';

class FetchImages extends Usecase<ImageListResponse, FetchImageParams> {
  final UnsplashRepository repository;

  FetchImages({required this.repository});

  @override
  Future<Either<CustomError, ImageListResponse>> call(FetchImageParams params) async {
    return await repository.fetchImages(params.page);
  }
}

class FetchImageParams {
  final int page;
  final int perPage;

  FetchImageParams(this.page, this.perPage);
}
