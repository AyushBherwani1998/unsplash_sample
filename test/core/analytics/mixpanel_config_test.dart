import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unsplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unsplash_sample/core/config/unleash_config.dart';
import 'package:unsplash_sample/core/utils/target_platform_extended.dart';
import 'package:unsplash_sample/core/utils/web_platform_resolver.dart';

import '../../service_locator_mock.dart';

void main() {
  late final MixpanelConfig mixpanelConfig;
  late final Mixpanel mixpanelMock;
  late final TargetPlatformExtended targetPlatformExtended;
  late final WebPlatformResolver webPlatformResolver;

  setUp(() {
    SerivceLocatorMock.initialize();
    mixpanelMock = SerivceLocatorMock.getIt<Mixpanel>();
    webPlatformResolver = SerivceLocatorMock.getIt<WebPlatformResolver>();
    targetPlatformExtended = TargetPlatformExtendedImpl(webPlatformResolver);
    mixpanelConfig = MixpanelConfigImpl(targetPlatformExtended);
  });

  test('Mixpanel config tests', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    mixpanelConfig.trackImageDetailsEvent("1");
    mixpanelConfig.trackLikeEventForExperimentation(
      photoId: "1",
      likeButtonPosition: LikeButtonPosition.gridTile,
    );
    mixpanelConfig.trackLikeVariant(LikeButtonPosition.gridTile);

    verify(
      () => mixpanelMock.track(any(), properties: any(named: 'properties')),
    ).called(3);
    debugDefaultTargetPlatformOverride = null;
  });
}
