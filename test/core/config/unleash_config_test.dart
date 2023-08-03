import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unleash/unleash.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';

import '../mocks/unleash_mock.dart';

void main() {
  late final UnleashConfig unleashConifg;
  late final Unleash unleashMock;

  group('UnleashConfig tests', () {
    setUpAll(() {
      unleashMock = UnleashMock();
      unleashConifg = UnleashConfigImp(unleashMock);
    });

    test(
      "returns true if the remote flag for isImageDetailsEnabled if true",
      () {
        when(() => unleashMock.isEnabled(isImageDetailsEnabled))
            .thenReturn(true);

        expect(unleashConifg.isDetailsPageEnabled, isTrue);
      },
    );

    test(
      "returns false if the remote flag for isImageDetailsEnabled if false",
      () {
        when(() => unleashMock.isEnabled(isImageDetailsEnabled))
            .thenReturn(false);

        expect(unleashConifg.isDetailsPageEnabled, isFalse);
      },
    );
  });
}
