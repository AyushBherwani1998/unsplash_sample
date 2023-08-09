import 'package:unleash_proxy_client_flutter/unleash_proxy_client_flutter.dart';

const String isImageDetailsEnabledToggleKey = "isImageDetailsEnabled";

abstract class UnleashConfig {
  bool get isDetailsPageEnabled;
}

class UnleashConfigImpl extends UnleashConfig {
  final UnleashClient unleash;

  UnleashConfigImpl(this.unleash);

  @override
  bool get isDetailsPageEnabled =>
      unleash.isEnabled(isImageDetailsEnabledToggleKey);
}
