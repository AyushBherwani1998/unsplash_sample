import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:unsplash_sample/core/utils/string_constants.dart';
import 'package:unsplash_sample/features/home/domain/entities/image.dart';
import 'package:unsplash_sample/features/home/domain/usecases/fetch_images.dart';

part 'unsplash_image_event.dart';
part 'unsplash_image_state.dart';

class UnsplashImageBloc extends Bloc<UnsplashImageEvent, UnsplashImageState> {
  final FetchImages fetchImages;

  UnsplashImageBloc(this.fetchImages) : super(UnsplashImageInitialState()) {
    on<UnsplashImageEvent>(
      (event, emit) async {
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
            emit(UnsplashImageLoadedState(imageList, event.params.page));
          });
        }
      },
      transformer: (event, mapper) {
        return droppable<UnsplashImageEvent>().call(
          event.throttle(const Duration(milliseconds: 100)),
          mapper,
        );
      },
    );
  }
}
