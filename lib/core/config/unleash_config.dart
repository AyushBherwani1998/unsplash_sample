import 'package:unleash_proxy_client_flutter/unleash_proxy_client_flutter.dart';

const String isImageDetailsEnabledToggleKey = "isImageDetailsEnabled";
const String likeOptionExperimentKey = "likeOptionExperiment";

enum LikeButtonPosition { gridTile, imageDetails }

abstract class UnleashConfig {
  bool get isDetailsPageEnabled;
  bool get isLikeOptionExperimentEnabled;
  LikeButtonPosition get likeButtonPosition;
}

class UnleashConfigImpl extends UnleashConfig {
  final UnleashClient unleash;

  UnleashConfigImpl(this.unleash);

  @override
  bool get isDetailsPageEnabled =>
      unleash.isEnabled(isImageDetailsEnabledToggleKey);

  @override
  bool get isLikeOptionExperimentEnabled =>
      unleash.isEnabled(likeOptionExperimentKey);

  @override
  LikeButtonPosition get likeButtonPosition {
    final variant = unleash.getVariant(likeOptionExperimentKey);
    return LikeButtonPosition.values.byName(variant.name);
  }
}
