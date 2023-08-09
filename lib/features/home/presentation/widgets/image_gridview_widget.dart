import 'package:flutter/material.dart';
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
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            final image = images[index];
            return ImageTile(
              image: image,
              unleashConfig: unleashConfig,
            );
          },
          itemCount: images.length,
        ),
      ],
    );
  }
}
