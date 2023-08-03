import 'package:unleash_proxy_client_flutter/unleash_proxy_client_flutter.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';

abstract class UnleashConfig {
  bool get isDetailsPageEnabled;
}

class UnleashConfigImp extends UnleashConfig {
  final UnleashClient unleash;

  UnleashConfigImp(this.unleash);

  @override
  bool get isDetailsPageEnabled => unleash.isEnabled(isImageDetailsEnabled);
}
