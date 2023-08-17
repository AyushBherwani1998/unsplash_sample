import 'package:flutter/foundation.dart';
import 'package:unplash_sample/core/utils/web_platform_resolver.dart';

abstract class TargetPlatformExtended {
  bool get isMobile;
  bool get isDesktop;
  bool get isWeb;
}

class TargetPlatformExtendedImpl extends TargetPlatformExtended {
  final WebPlatformResolver webPlatformResolver;

  TargetPlatformExtendedImpl(this.webPlatformResolver);

  @override
  bool get isDesktop {
    return defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }

  @override
  bool get isMobile {
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
  }

  @override
  bool get isWeb => webPlatformResolver.isWeb;
}

