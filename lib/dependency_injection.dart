import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:unleash/unleash.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/features/home/data/datasources/unsplash_remote_datasource.dart';
import 'package:unplash_sample/features/home/data/repositories/unsplash_repository_impl.dart';
import 'package:unplash_sample/features/home/domain/repositories/unsplash_repository.dart';
import 'package:unplash_sample/features/home/domain/usecases/fetch_images.dart';
import 'package:unplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';

class DependencyInjection {
  DependencyInjection._();

  static GetIt get getIt => GetIt.instance;

  static Future<void> initialize() async {
    getIt.registerFactory(() => UnsplashImageBloc(getIt()));

    getIt.registerLazySingleton(() => FetchImages(repository: getIt()));

    getIt.registerLazySingleton<UnsplashRepository>(
      () => UnsplashRepositoryImpl(getIt()),
    );

    getIt.registerLazySingleton<UnsplashRemoteDataSource>(
      () => UnsplashRemoteDataSourceImpl(getIt()),
    );

    final unleash = await Unleash.init(
      UnleashSettings(
        appName: "unplash_demo",
        instanceId: "instanceId",
        // TODO(AyushBherwani1998): Fix me
        unleashApi: Uri.parse(""),
        apiToken: dotenv.env["UNLEASH_API_KEY"] as String,
      ),
    );

    getIt.registerLazySingleton(() => unleash);
    getIt.registerLazySingleton(() => UnleashConfigImp(getIt()));

    getIt.registerLazySingleton(() => Dio());
  }
}
