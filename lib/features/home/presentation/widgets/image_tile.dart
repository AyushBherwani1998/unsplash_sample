import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/routes/auto_router.dart';
import 'package:unplash_sample/dependency_injection.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_tile_footer.dart';
import 'package:unplash_sample/features/home/presentation/widgets/image_tile_header.dart';

class ImageTile extends StatelessWidget {
  final UnsplashImage image;
  final UnleashConfig unleashConfig;

  const ImageTile({
    super.key,
    required this.image,
    required this.unleashConfig,
  });

  bool get isFooterEnabled {
    return unleashConfig.isLikeOptionExperimentEnabled &&
        unleashConfig.likeButtonPosition == LikeButtonPosition.gridTile;
  }

  Widget tileGap() => const SizedBox(height: 4);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image.url,
      cacheManager: DependencyInjection.getIt<DefaultCacheManager>(),
      imageBuilder: (context, provider) {
        return Column(
          children: [
            ImageTileHeader(image: image),
            tileGap(),
            GestureDetector(
              onTap: () {
                if (unleashConfig.isDetailsPageEnabled) {
                  AutoRouter.of(context).push(
                    ImageDetailsRoute(id: image.id),
                  );
                }
              },
              child: Image(image: provider),
            ),
            tileGap(),
            if (isFooterEnabled) ...[
              ImageTileFooter(image: image),
            ],
          ],
        );
      },
    );
  }
}
