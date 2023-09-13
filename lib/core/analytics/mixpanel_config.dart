import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:unsplash_sample/core/config/unleash_config.dart';
import 'package:unsplash_sample/core/utils/target_platform_extended.dart';
import 'package:unsplash_sample/service_locator.dart';

abstract class MixpanelConfig {
  void trackImageDetailsEvent(String photoId);
  void trackLikeEventForExperimentation({
    required LikeButtonPosition likeButtonPosition,
    required String photoId,
  });
  void trackLikeVariant(LikeButtonPosition likeButtonPosition);
}

class MixpanelConfigImpl implements MixpanelConfig {
  final TargetPlatformExtended targetPlatformExtended;

  MixpanelConfigImpl(this.targetPlatformExtended);

  Mixpanel get mixpanel {
    return ServiceLocator.getIt<Mixpanel>();
  }

  @override
  void trackImageDetailsEvent(String photoId) {
    if (targetPlatformExtended.isMobile) {
      mixpanel.track(
        "image-details",
        properties: {"photoId": photoId},
      );
    }
  }

  @override
  void trackLikeEventForExperimentation({
    required LikeButtonPosition likeButtonPosition,
    required String photoId,
  }) {
    if (targetPlatformExtended.isMobile) {
      mixpanel.track('like-experimentation', properties: {
        "variant": describeEnum(likeButtonPosition),
        "photoId": photoId,
      });
    }
  }

  @override
  void trackLikeVariant(LikeButtonPosition likeButtonPosition) {
    if (targetPlatformExtended.isMobile) {
      mixpanel.track('like-variant', properties: {
        "variant": describeEnum(likeButtonPosition),
      });
    }
  }
}
