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

  const UnsplashImage({
    required this.id,
    required this.url,
  });

  @override
  List<Object?> get props => [id, url];
}
