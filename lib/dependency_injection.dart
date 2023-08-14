import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:unleash_proxy_client_flutter/unleash_proxy_client_flutter.dart';
import 'package:unplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/routes/auto_router.dart';
import 'package:unplash_sample/features/home/data/datasources/unsplash_remote_datasource.dart';
import 'package:unplash_sample/features/home/data/repositories/unsplash_repository_impl.dart';
import 'package:unplash_sample/features/home/domain/repositories/unsplash_repository.dart';
import 'package:unplash_sample/features/home/domain/usecases/fetch_images.dart';
import 'package:unplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';
import 'package:unplash_sample/features/image_details/data/datasources/image_details_remote_datasource.dart';
import 'package:unplash_sample/features/image_details/data/repositories/image_details_repository_impl.dart';
import 'package:unplash_sample/features/image_details/domain/repositories/image_details_repository.dart';
import 'package:unplash_sample/features/image_details/domain/usecases/fetch_image_details.dart';
import 'package:unplash_sample/features/image_details/presentation/bloc/image_details_bloc.dart';

class DependencyInjection {
  DependencyInjection._();

  static GetIt get getIt => GetIt.instance;

  static Future<void> initialize() async {
    getIt.registerFactory(() => UnsplashImageBloc(getIt()));
    getIt.registerFactory(() => ImageDetailsBloc(getIt()));

    getIt.registerLazySingleton(() => FetchImageDetails(getIt()));
    getIt.registerLazySingleton(() => FetchImages(repository: getIt()));

    getIt.registerLazySingleton<ImageDetailsRepository>(
      () => ImageDetailsRepositoryIml(getIt()),
    );
    getIt.registerLazySingleton<UnsplashRepository>(
      () => UnsplashRepositoryImpl(getIt()),
    );

    getIt.registerLazySingleton<ImageDetailsRemoteDataSource>(
      () => ImageDetailsRemoteDataSourceImpl(getIt()),
    );
    getIt.registerLazySingleton<UnsplashRemoteDataSource>(
      () => UnsplashRemoteDataSourceImpl(getIt()),
    );

    final unleash = UnleashClient(
      url: Uri.parse('http://127.0.0.1:4242/api/frontend'),
      clientKey: dotenv.env["UNLEASH_API_KEY"] as String,
      appName: 'unplash_demo',
    );

    await unleash.start();

    getIt.registerLazySingleton(() => unleash);
    getIt.registerLazySingleton<UnleashConfig>(
      () => UnleashConfigImpl(getIt()),
    );

    final mixPanel = await Mixpanel.init(
      dotenv.env["MIXPANEL_KEY"] as String,
      trackAutomaticEvents: false,
    );

    getIt.registerLazySingleton(() => mixPanel);

    getIt.registerLazySingleton<MixpanelConfig>(
      () => MixpanelConfigImpl(getIt()),
    );

    final options = BaseOptions(
      baseUrl: "https://api.unsplash.com",
      headers: {"Authorization": "Client-ID ${dotenv.env["UNSPLASH_API_KEY"]}"},
    );

    getIt.registerLazySingleton(() => Dio(options));

    getIt.registerFactory(() => UnsplashSampleRouter());
  }
}
