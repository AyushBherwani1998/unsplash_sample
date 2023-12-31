import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:unsplash_sample/features/image_details/domain/entities/image_details.dart';
import 'package:unsplash_sample/features/image_details/presentation/widgets/details_tile.dart';

class ImageDetailsWidget extends StatelessWidget {
  final ImageDetails imageDetails;

  const ImageDetailsWidget({
    super.key,
    required this.imageDetails,
  });

  Widget get vSeparator => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: imageDetails.url,
              fit: BoxFit.cover,
              placeholder: (_, __) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: BlurHash(hash: imageDetails.blurHash),
                );
              },
            ),
          ),
          vSeparator,
          const Divider(),
          const SizedBox(height: 4),
          DetailsTile(imageDetails: imageDetails),
        ],
      ),
    );
  }
}
