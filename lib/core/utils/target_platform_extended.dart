import 'package:flutter/foundation.dart';

abstract class TargetPlatformExtended {
  bool get isMobile;
  bool get isDesktop;
  bool get isWeb;
}

class TargetPlatformExtendedImpl extends TargetPlatformExtended {
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
  bool get isWeb => kIsWeb;
}
