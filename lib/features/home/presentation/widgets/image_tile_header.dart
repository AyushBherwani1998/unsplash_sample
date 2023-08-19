import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:unplash_sample/dependency_injection.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';

class ImageTileHeader extends StatelessWidget {
  final UnsplashImage image;
  const ImageTileHeader({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          cacheManager: DependencyInjection.getIt<DefaultCacheManager>(),
          imageUrl: image.profileImage,
          imageBuilder: (context, provider) {
            return Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: provider),
              ),
            );
          },
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            image.userName,
            style: Theme.of(context).textTheme.bodyLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
