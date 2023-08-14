import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/routes/auto_router.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';

class ImageTile extends StatelessWidget {
  final UnsplashImage image;
  final UnleashConfig unleashConfig;

  const ImageTile({
    super.key,
    required this.image,
    required this.unleashConfig,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (unleashConfig.isDetailsPageEnabled) {
          AutoRouter.of(context).push(
            ImageDetailsRoute(id: image.id),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        child: CachedNetworkImage(
          imageUrl: image.url,
        ),
      ),
    );
  }
}
