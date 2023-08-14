import 'package:mixpanel_flutter/mixpanel_flutter.dart';

abstract class MixpanelConfig {
  void trackImageDetaislsEvent(String photoId);
  void trackShareEventForExperimentation({
    required String variant,
    required String photoId,
  });
}

class MixpanelConfigImpl implements MixpanelConfig {
  final Mixpanel mixpanel;

  MixpanelConfigImpl(this.mixpanel);

  @override
  void trackImageDetaislsEvent(String photoId) {
    mixpanel.track(
      "image-details",
      properties: {"photoId": photoId},
    );
  }

  @override
  void trackShareEventForExperimentation({
    required String variant,
    required String photoId,
  }) {
    mixpanel.track('share-experimentation', properties: {
      "variant": variant,
      "photoId": photoId,
    });
  }
}
