import 'package:unleash/unleash.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';

abstract class UnleashConfig {
  bool get isDetailsPageEnabled;
}

class UnleashConfigImp extends UnleashConfig {
  final Unleash unleash;

  UnleashConfigImp(this.unleash);

  @override
  bool get isDetailsPageEnabled => unleash.isEnabled(isImageDetailsEnabled, defaultValue: false);
}
