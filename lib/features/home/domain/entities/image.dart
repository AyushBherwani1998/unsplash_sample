import 'package:equatable/equatable.dart';

class UnsplashImageList extends Equatable {
  final List<UnsplashImage> images;

  const UnsplashImageList(this.images);

  @override
  List<Object?> get props => [images];
}

class UnsplashImage extends Equatable {
  final String id;
  final String url;
  final String blurHash;
  final int likes;
  final String userName;
  final String profileImage;

  const UnsplashImage({
    required this.id,
    required this.url,
    required this.blurHash,
    required this.likes,
    required this.userName,
    required this.profileImage,
  });

  @override
  List<Object?> get props => [
        id,
        url,
        blurHash,
        likes,
        userName,
        profileImage,
      ];
}
