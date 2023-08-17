import 'package:flutter/foundation.dart';

abstract class WebPlatformResolver {
  bool get isWeb;
}

class WebPlatformResolverImpl extends WebPlatformResolver {
  @override
  bool get isWeb => kIsWeb;
}