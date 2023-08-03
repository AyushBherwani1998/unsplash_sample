import 'package:flutter/material.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_tile.dart';

class ImageGridViewWidget extends StatelessWidget {
  final List<UnsplashImage> images;

  const ImageGridViewWidget({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            final image = images[index];
            return ImageTile(image: image);
          },
          itemCount: images.length,
        ),
      ],
    );
  }
}
