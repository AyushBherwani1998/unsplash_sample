import 'package:unleash_proxy_client_flutter/unleash_proxy_client_flutter.dart';

const String isImageDetailsEnabledToggleKey = "isImageDetailsEnabled";
const String shareOptionExperimentKey = "shareOptionExperiment";

enum ShareButtonPosition { gridTile, imageDetails }

abstract class UnleashConfig {
  bool get isDetailsPageEnabled;
  bool get isShareOptionExperimentEnabled;
  ShareButtonPosition get shareButtonPosition;
}

class UnleashConfigImpl extends UnleashConfig {
  final UnleashClient unleash;

  UnleashConfigImpl(this.unleash);

  @override
  bool get isDetailsPageEnabled =>
      unleash.isEnabled(isImageDetailsEnabledToggleKey);

  @override
  bool get isShareOptionExperimentEnabled =>
      unleash.isEnabled(shareOptionExperimentKey);

  @override
  ShareButtonPosition get shareButtonPosition {
    final variant = unleash.getVariant(shareOptionExperimentKey);
    return ShareButtonPosition.values.byName(variant.name);
  }
}
