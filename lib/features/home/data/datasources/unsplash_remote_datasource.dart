import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:unsplash_sample/core/utils/string_constants.dart';
import 'package:unsplash_sample/features/home/data/models/image_model.dart';
import 'package:unsplash_sample/features/home/domain/entities/image.dart';

abstract class UnsplashRemoteDataSource {
  Future<List<UnsplashImage>> fetchImages(int pageNumber, int perPage);
}

class UnsplashRemoteDataSourceImpl implements UnsplashRemoteDataSource {
  final Dio dio;

  UnsplashRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UnsplashImage>> fetchImages(int pageNumber, int perPage) async {
    try {
      final response = await dio.get<List>(
        '/photos',
        queryParameters: {
          "page": pageNumber,
          "per_page": perPage,
        },
      );

      if (response.statusCode == 200) {
        final imageModelListModel = UnsplashImageListModel.fromJson(
          List<Map<String, dynamic>>.from(response.data!),
        );

        return imageModelListModel.images;
      }
      throw Exception(serverErrorMessage);
    } catch (e, _) {
      log(e.toString(), stackTrace: _);
      rethrow;
    }
  }
}
