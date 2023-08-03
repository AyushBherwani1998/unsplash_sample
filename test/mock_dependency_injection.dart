import 'package:get_it/get_it.dart';
import 'package:unplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';

class MockDependencyInjection {
  MockDependencyInjection._();

  static GetIt get getIt => GetIt.instance;

  static void initialize(UnsplashImageBloc bloc) {
    getIt.registerFactory<UnsplashImageBloc>(() => bloc);
  }
}
