import 'package:unplash_sample/features/home/domain/entities/image.dart';

abstract class UnsplashRemoteDataSource {
  Future<List<UnsplashImage>> fetchImages(int pageNumber);
}