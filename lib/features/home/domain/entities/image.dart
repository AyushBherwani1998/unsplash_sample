import 'package:equatable/equatable.dart';

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
