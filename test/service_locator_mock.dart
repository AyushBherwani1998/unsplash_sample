import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:unsplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unsplash_sample/core/config/unleash_config.dart';
import 'package:unsplash_sample/core/utils/web_platform_resolver.dart';
import 'package:unsplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';
import 'package:unsplash_sample/features/image_details/presentation/bloc/image_details_bloc.dart';

import 'core/mocks/cache_manager_mock.dart';
import 'core/mocks/mixpanel_config_mock.dart';
import 'core/mocks/mixpanel_mock.dart';
import 'core/mocks/unelash_conifg_mock.dart';
import 'core/mocks/web_platform_resolver_mock.dart';

class SerivceLocatorMock {
  SerivceLocatorMock._();

  static GetIt get getIt => GetIt.instance;

  static void initialize({
    UnsplashImageBloc? unsplashImageBloc,
    ImageDetailsBloc? imageDetailsBloc,
  }) {
    getIt.registerLazySingleton<DefaultCacheManager>(() => MockCacheManager());
    getIt.registerLazySingleton<Mixpanel>(() => MixpanelMock());
    getIt.registerLazySingleton<UnleashConfig>(() => UnleashConfigMock());
    getIt.registerLazySingleton<MixpanelConfig>(() => MixPanelConfigMock());
    getIt.registerLazySingleton<WebPlatformResolver>(
      () => WebPlatformResolverMock(),
    );

    if (unsplashImageBloc != null) {
      getIt.registerFactory<UnsplashImageBloc>(() => unsplashImageBloc);
    }
    if (imageDetailsBloc != null) {
      getIt.registerFactory<ImageDetailsBloc>(() => imageDetailsBloc);
    }
  }
}
