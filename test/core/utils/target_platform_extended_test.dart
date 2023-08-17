import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unplash_sample/core/utils/target_platform_extended.dart';

void main() {
  group('TargetPlatformExtended tests', () {
    late final TargetPlatformExtended targetPlatformExtended;

    setUpAll(() {
      targetPlatformExtended = TargetPlatformExtendedImpl();
    });

    test('should return isMobile if running on mobile os', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      expect(targetPlatformExtended.isMobile, isTrue);
      debugDefaultTargetPlatformOverride = null;
    });

    test('should return isDesktop if running on desktop os', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(targetPlatformExtended.isDesktop, isTrue);
      debugDefaultTargetPlatformOverride = null;
    });
  });
}
