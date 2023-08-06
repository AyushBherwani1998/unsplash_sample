import 'package:get_it/get_it.dart';
import 'package:unplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';
import 'package:unplash_sample/features/image_details/presentation/bloc/image_details_bloc.dart';

class MockDependencyInjection {
  MockDependencyInjection._();

  static GetIt get getIt => GetIt.instance;

  static void initialize({
    UnsplashImageBloc? unsplashImageBloc,
    ImageDetailsBloc? imageDetailsBloc,
  }) {
    if (unsplashImageBloc != null) {
      getIt.registerFactory<UnsplashImageBloc>(() => unsplashImageBloc);
    }
    if (imageDetailsBloc != null) {
      getIt.registerFactory<ImageDetailsBloc>(() => imageDetailsBloc);
    }
  }
}
