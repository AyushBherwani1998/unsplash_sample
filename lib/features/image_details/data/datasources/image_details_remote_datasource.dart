import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';
import 'package:unplash_sample/features/image_details/data/models/image_details_model.dart';

abstract class ImageDetailsRemoteDataSource {
  Future<ImageDetailsModel> fetchImageDetails(String id);
}

class ImageDetailsRemoteDataSourceImpl implements ImageDetailsRemoteDataSource {
  final Dio dio;

  ImageDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<ImageDetailsModel> fetchImageDetails(String id) async {
    try {
      final response = await dio.get(
        'https://api.unsplash.com/photos/:$id',
        options: Options(
          headers: {
            "Authorization": "Client-ID ${dotenv.env["UNSPLASH_API_KEY"]}"
          },
        ),
      );

      if (response.statusCode == 200) {
        return ImageDetailsModel.fromJson(response.data);
      }

      throw Exception(serverErrorMessage);
    } catch (e, _) {
      rethrow;
    }
  }
}
