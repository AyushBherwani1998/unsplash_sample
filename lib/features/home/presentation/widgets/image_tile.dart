import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';
import 'package:unplash_sample/features/image_details/presentation/pages/image_details_page.dart';

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
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ImageDetailsPage(id: image.id);
            }),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        child: CachedNetworkImage(
          imageUrl: image.url,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
