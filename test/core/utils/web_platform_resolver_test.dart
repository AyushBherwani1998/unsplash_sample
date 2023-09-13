@TestOn("browser")

import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_sample/core/utils/web_platform_resolver.dart';

void main() {
  final WebPlatformResolver webPlatformResolver = WebPlatformResolverImpl();
  test('WebPlatformResolver.isWeb returns true on browser', () {
    expect(webPlatformResolver.isWeb, isTrue);
  });
}
