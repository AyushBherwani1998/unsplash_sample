import 'package:unplash_sample/features/image_details/domain/entities/image_details.dart';

class ImageDetailsModel extends ImageDetails {
  const ImageDetailsModel({
    required super.url,
    required super.description,
    required super.downloads,
    required super.likes,
    required super.blurHash,
  });

  factory ImageDetailsModel.fromJson(Map<String, dynamic> json) {
    return ImageDetailsModel(
      url: json['urls']['raw'].toString(),
      description: json['description']?.toString() ?? "Description not available!",
      downloads: int.parse(json['downloads'].toString()),
      likes: int.parse(json['likes'].toString()),
      blurHash: json['blur_hash'].toString(),
    );
  }
}
