import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_sample/core/config/unleash_config.dart';
import 'package:unsplash_sample/core/widgets/like_button.dart';
import 'package:unsplash_sample/features/home/domain/entities/image.dart';

class ImageTileFooter extends StatefulWidget {
  final UnsplashImage image;

  const ImageTileFooter({super.key, required this.image});

  @override
  State<ImageTileFooter> createState() => _ImageTileFooterState();
}

class _ImageTileFooterState extends State<ImageTileFooter> {
  late final ValueNotifier<bool> isLikedNotifier;

  @override
  void initState() {
    super.initState();
    isLikedNotifier = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        LikeButton(
          isLikedNotifier: isLikedNotifier,
          photoId: widget.image.id,
          likeButtonPosition: LikeButtonPosition.gridTile,
        ),
        Text(widget.image.likes.toString()),
      ],
    );
  }
}
