@TestOn("browser")

import 'package:flutter_test/flutter_test.dart';
import 'package:unplash_sample/core/utils/target_platform_extended.dart';

void main() {
  final WebPlatformResolver webPlatformResolver = WebPlatformResolverImpl();
  test('WebPlatformResolver.isWeb returns true on browser', () {
    expect(webPlatformResolver.isWeb, isTrue);
  });
}
