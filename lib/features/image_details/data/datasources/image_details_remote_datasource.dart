import 'package:dio/dio.dart';
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
      final response = await dio.get<Map>('/photos/$id');

      if (response.statusCode == 200) {
        return ImageDetailsModel.fromJson(
          Map<String, dynamic>.from(response.data!),
        );
      }

      throw Exception(serverErrorMessage);
    } catch (e, _) {
      rethrow;
    }
  }
}
