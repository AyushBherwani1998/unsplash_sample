import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unsplash_sample/core/config/unleash_config.dart';
import 'package:unsplash_sample/features/home/domain/entities/image.dart';
import 'package:unsplash_sample/features/home/presentation/widgets/image_tile.dart';
import 'package:unsplash_sample/service_locator.dart';

class ImageGridViewWidget extends StatelessWidget {
  final List<UnsplashImage> images;
  final ScrollController controller;

  const ImageGridViewWidget({
    super.key,
    required this.images,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final unleashConfig = ServiceLocator.getIt<UnleashConfig>();
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          sliver: SliverMasonryGrid(
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
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
              crossAxisCount: 2,
            ),
          ),
        ),
      ],
    );
  }
}
