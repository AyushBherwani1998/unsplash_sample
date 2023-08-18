import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';

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
        ValueListenableBuilder<bool>(
          valueListenable: isLikedNotifier,
          builder: (context, isLiked, child) {
            return IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              iconSize: 20,
              isSelected: isLiked,
              splashColor: Colors.red,
              onPressed: () {
                isLikedNotifier.value = !isLikedNotifier.value;
              },
              selectedIcon: const Icon(
                CupertinoIcons.heart_fill,
                color: Colors.redAccent,
              ),
              icon: const Icon(CupertinoIcons.heart),
            );
          },
        ),
        Text(widget.image.likes.toString()),
      ],
    );
  }
}
