import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:unplash_sample/features/home/data/models/image_model.dart';

abstract class UnsplashRemoteDataSource {
  Future<List<UnsplashImageModel>> fetchImages(int pageNumber);
}

class UnsplashRemoteDataSourceImpl implements UnsplashRemoteDataSource {
  final Dio dio;

  UnsplashRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UnsplashImageModel>> fetchImages(int pageNumber) async {
    try {
      final response = await dio.get('https://api.unsplash.com/photos');
      if (response.statusCode == 200) {
        final jsonList = List.from(response.data);
        final List<UnsplashImageModel> imageModelList = [];
        for (final jsonMap in jsonList) {
          final imageModel = UnsplashImageModel.fromJson(jsonMap);
          imageModelList.add(imageModel);
        }
        return imageModelList;
      }
      throw Exception("Something went wrong");
    } catch (e, _) {
      log(e.toString(), stackTrace: _);
      rethrow;
    }
  }
}
