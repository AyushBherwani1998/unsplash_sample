import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';

class ImageTile extends StatelessWidget {
  final UnsplashImage image;

  const ImageTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: CachedNetworkImage(
        imageUrl: image.url,
        fit: BoxFit.fill,
      ),
    );
  }
}
