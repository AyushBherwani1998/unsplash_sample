import 'package:unplash_sample/features/home/domain/entities/image.dart';

class UnsplashImageModel extends UnsplashImage {
  const UnsplashImageModel({required super.id, required super.url});

  factory UnsplashImageModel.fromJson(Map<String, dynamic> json) {
    return UnsplashImageModel(id: json['id'], url: json['urls']['raw']);
  }
}
