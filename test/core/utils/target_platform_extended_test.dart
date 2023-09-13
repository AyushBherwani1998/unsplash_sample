import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unsplash_sample/core/utils/target_platform_extended.dart';
import 'package:unsplash_sample/core/utils/web_platform_resolver.dart';

import '../../service_locator_mock.dart';

void main() {
  group('TargetPlatformExtended tests', () {
    late final TargetPlatformExtended targetPlatformExtended;
    late final WebPlatformResolver webPlatformResolver;

    setUpAll(() {
      SerivceLocatorMock.initialize();
      webPlatformResolver = SerivceLocatorMock.getIt<WebPlatformResolver>();
      targetPlatformExtended = TargetPlatformExtendedImpl(webPlatformResolver);
    });

    test('should return isMobile true if running on mobile os', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      expect(targetPlatformExtended.isMobile, isTrue);
      debugDefaultTargetPlatformOverride = null;
    });

    test('should return isDesktop true if running on desktop os', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(targetPlatformExtended.isDesktop, isTrue);
      debugDefaultTargetPlatformOverride = null;
    });

    test('should return isWeb true if running on web', () {
      when(() => webPlatformResolver.isWeb).thenReturn(true);
      expect(targetPlatformExtended.isWeb, isTrue);
    });
  });
}
