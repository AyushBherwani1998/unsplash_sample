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
        final isInitial = event.params.page == 1;
        late final List<UnsplashImage> imageList;
        if (isInitial) {
          imageList = List<UnsplashImage>.empty(growable: true);
          emit(UnsplashImageLoadingState());
        } else {
          imageList = List.from((state as UnsplashImageLoadedState).images);
          emit(UnsplashImagePaginatedLoadingState());
        }

        final imagesEither = await fetchImages(event.params);
        imagesEither.fold((error) {
          if (isInitial) {
            emit(const UnsplashImageErrorState(serverErrorMessage));
          } else {
            emit(const UnsplashImagePaginatedErrorState(serverErrorMessage));
          }
        }, (images) {
          imageList.addAll(images);
          emit(UnsplashImageLoadedState(imageList));
        });
      }
    });
  }
}
