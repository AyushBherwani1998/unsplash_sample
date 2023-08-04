import 'package:equatable/equatable.dart';

class ImageDetails extends Equatable {
  final String url;
  final String description;
  final int downloads;
  final int likes;
  final List<Map<String, dynamic>> tags;

  const ImageDetails({
    required this.url,
    required this.description,
    required this.downloads,
    required this.likes,
    required this.tags,
  });

  @override
  List<Object?> get props => [description, downloads, likes, tags];
}
