import 'package:unplash_sample/features/home/domain/entities/image.dart';

class UnsplashImageListModel extends UnsplashImageList {
  const UnsplashImageListModel(super.images);

  factory UnsplashImageListModel.fromJson(List<Map<String, dynamic>> json) {
    final List<UnsplashImageModel> imageModelList = [];
    for (final jsonMap in json) {
      final imageModel = UnsplashImageModel.fromJson(jsonMap);
      imageModelList.add(imageModel);
    }
    return UnsplashImageListModel(imageModelList);
  }
}

class UnsplashImageModel extends UnsplashImage {
  const UnsplashImageModel({
    required super.id,
    required super.url,
    required super.blurHash,
    required super.likes,
    required super.userName,
    required super.profileImage,
  });

  factory UnsplashImageModel.fromJson(Map<String, dynamic> json) {
    return UnsplashImageModel(
      id: json['id'].toString(),
      url: json['urls']['small'].toString(),
      blurHash: json['blur_hash'].toString(),
      likes: int.parse(json['likes'].toString()),
      userName: json['user']['username'].toString(),
      profileImage: json['user']['profile_image']['small'].toString(),
    );
  }
}
