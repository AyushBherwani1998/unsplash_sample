import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';
import 'package:unplash_sample/features/home/data/models/image_model.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';

abstract class UnsplashRemoteDataSource {
  Future<List<UnsplashImage>> fetchImages(int pageNumber);
}

class UnsplashRemoteDataSourceImpl implements UnsplashRemoteDataSource {
  final Dio dio;

  UnsplashRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UnsplashImage>> fetchImages(int pageNumber) async {
    try {
      final response = await dio.get(
        'https://api.unsplash.com/photos',
        queryParameters: {"page": 1},
        options: Options(
          headers: {
            "Authorization": "Client-ID ${dotenv.env["UNSPLASH_API_KEY"]}"
          },
        ),
      );
      if (response.statusCode == 200) {
        final imageModelListModel = UnsplashImageListModel.fromJson(
          List.from(response.data),
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
