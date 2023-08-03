import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';
import 'package:unplash_sample/features/home/domain/entities/image.dart';
import 'package:unplash_sample/features/home/domain/usecases/fetch_images.dart';

part 'unsplash_image_event.dart';
part 'unsplash_image_state.dart';

class UnsplashImageBloc extends Bloc<UnsplashImageEvent, UnsplashImageState> {
  final FetchImages fetchImages;

  UnsplashImageBloc(this.fetchImages) : super(UnsplashImageInitialState()) {
    on<UnsplashImageEvent>((event, emit) async {
      if (event is FetchImageEvent) {
        emit(UnsplashImageLoadingState());
        final imagesEither = await fetchImages(event.params);
        imagesEither.fold((error) {
          emit(const UnsplashImageErrorState(serverErrorMessage));
        }, (images) {
          emit(UnsplashImageLoadedState(images));
        });
      }
    });
  }
}
