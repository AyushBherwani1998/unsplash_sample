import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/dependency_injection.dart';

class LikeButton extends StatelessWidget {
  final ValueNotifier<bool> isLikedNotifier;
  final LikeButtonPosition likeButtonPosition;
  final String photoId;

  const LikeButton({
    super.key,
    required this.isLikedNotifier,
    required this.likeButtonPosition,
    required this.photoId,
  });

  void _fireMixpanelEvent() {
    final mixpanelConfig = DependencyInjection.getIt<MixpanelConfig>();
    mixpanelConfig.trackLikeEventForExperimentation(
      likeButtonPosition: likeButtonPosition,
      photoId: photoId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
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
            _fireMixpanelEvent();
          },
          selectedIcon: const Icon(
            CupertinoIcons.heart_fill,
            color: Colors.redAccent,
          ),
          icon: const Icon(CupertinoIcons.heart),
        );
      },
    );
  }
}
