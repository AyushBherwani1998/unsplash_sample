import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:unplash_sample/core/utils/target_platform_extended.dart';
import 'package:unplash_sample/dependency_injection.dart';

abstract class MixpanelConfig {
  void trackImageDetaislsEvent(String photoId);
  void trackLikeEventForExperimentation({
    required String variant,
    required String photoId,
  });
}

class MixpanelConfigImpl implements MixpanelConfig {
  final TargetPlatformExtended targetPlatformExtended;

  MixpanelConfigImpl(this.targetPlatformExtended);

  Mixpanel get mixpanel {
    return DependencyInjection.getIt<Mixpanel>();
  }

  @override
  void trackImageDetaislsEvent(String photoId) {
    if (targetPlatformExtended.isMobile) {
      mixpanel.track(
        "image-details",
        properties: {"photoId": photoId},
      );
    }
  }

  @override
  void trackLikeEventForExperimentation({
    required String variant,
    required String photoId,
  }) {
    if (targetPlatformExtended.isMobile) {
      mixpanel.track('like-experimentation', properties: {
        "variant": variant,
        "photoId": photoId,
      });
    }
  }
}
