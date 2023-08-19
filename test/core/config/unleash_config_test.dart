import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unleash_proxy_client_flutter/unleash_proxy_client_flutter.dart';
import 'package:unleash_proxy_client_flutter/variant.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';

import '../mocks/unleash_mock.dart';

void main() {
  late final UnleashConfig unleashConifg;
  late final UnleashClient unleashMock;

  group('UnleashConfig tests', () {
    setUpAll(() {
      unleashMock = UnleashClientMock();
      unleashConifg = UnleashConfigImpl(unleashMock);
    });

    test(
      "returns true if the remote flag for isImageDetailsEnabled if true",
      () {
        when(() => unleashMock.isEnabled(isImageDetailsEnabledToggleKey))
            .thenReturn(true);

        expect(unleashConifg.isDetailsPageEnabled, isTrue);
      },
    );

    test(
      "returns false if the remote flag for isImageDetailsEnabled if false",
      () {
        when(() => unleashMock.isEnabled(isImageDetailsEnabledToggleKey))
            .thenReturn(false);

        expect(unleashConifg.isDetailsPageEnabled, isFalse);
      },
    );

    test(
      "returns true if the remote flag for shareOptionExperiment if true",
      () {
        when(() => unleashMock.isEnabled(likeOptionExperimentKey))
            .thenReturn(true);

        expect(unleashConifg.isLikeOptionExperimentEnabled, isTrue);
      },
    );

    test(
      "returns false if the remote flag for shareOptionExperiment if false",
      () {
        when(() => unleashMock.isEnabled(likeOptionExperimentKey))
            .thenReturn(false);

        expect(unleashConifg.isDetailsPageEnabled, isFalse);
      },
    );

    test('returns SharePosition if the shareOptionExperiment is enabled', () {
      when(() => unleashMock.getVariant(likeOptionExperimentKey)).thenReturn(
        Variant(
          name: describeEnum(LikeButtonPosition.gridTile),
          enabled: true,
        ),
      );

      expect(unleashConifg.likeButtonPosition, LikeButtonPosition.gridTile);
    });
  });
}
