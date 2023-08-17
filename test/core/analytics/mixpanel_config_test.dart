import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unplash_sample/core/utils/target_platform_extended.dart';

import '../../mock_dependency_injection.dart';

void main() {
  late final MixpanelConfig mixpanelConfig;
  late final Mixpanel mixpanelMock;
  late final TargetPlatformExtended targetPlatformExtended;

  setUp(() {
    MockDependencyInjection.initialize();
    mixpanelMock = MockDependencyInjection.getIt<Mixpanel>();
    targetPlatformExtended = TargetPlatformExtendedImpl();
    mixpanelConfig = MixpanelConfigImpl(targetPlatformExtended);
  });

  test('Mixpanel config tests', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    mixpanelConfig.trackImageDetaislsEvent("1");
    mixpanelConfig.trackShareEventForExperimentation(
      photoId: "1",
      variant: "gridTile",
    );

    verify(
      () => mixpanelMock.track(any(), properties: any(named: 'properties')),
    ).called(2);
    debugDefaultTargetPlatformOverride = null;
  });
}
