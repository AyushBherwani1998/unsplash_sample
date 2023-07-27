import 'package:equatable/equatable.dart';

class ImageListResponse extends Equatable {
  final String id;
  final String url;

  const ImageListResponse({
    required this.id,
    required this.url,
  });

  @override
  List<Object?> get props => [id, url];
}
