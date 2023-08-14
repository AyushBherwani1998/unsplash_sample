import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/analytics/mixpanel_config.dart';

import '../mocks/mixpanel_mock.dart';

void main() {
  late final MixpanelConfig mixpanelConfig;
  late final MixpanelMock mixpanelMock;

  setUp(() {
    mixpanelMock = MixpanelMock();
    mixpanelConfig = MixpanelConfigImpl(mixpanelMock);
  });

  test('Mixpanel config tests', () {
    mixpanelConfig.trackImageDetaislsEvent("1");
    mixpanelConfig.trackShareEventForExperimentation(
      photoId: "1",
      variant: "gridTile",
    );

    verify(
      () => mixpanelMock.track(any(), properties: any(named: 'properties')),
    ).called(2);
  });
}
