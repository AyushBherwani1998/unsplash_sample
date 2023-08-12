import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/dependency_injection.dart';
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
    final unleashConfig = DependencyInjection.getIt<UnleashConfig>();
    return CustomScrollView(
      slivers: [
        SliverMasonryGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final image = images[index];
              return ImageTile(
                image: image,
                unleashConfig: unleashConfig,
              );
            },
            childCount: images.length,
          ),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
        ),
      ],
    );
  }
}
