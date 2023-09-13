import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unsplash_sample/core/utils/string_constants.dart';
import 'package:unsplash_sample/features/image_details/domain/entities/image_details.dart';
import 'package:unsplash_sample/features/image_details/domain/usecases/fetch_image_details.dart';

part 'image_details_event.dart';
part 'image_details_state.dart';

class ImageDetailsBloc extends Bloc<ImageDetailsEvent, ImageDetailsState> {
  final FetchImageDetails fetchImageDetails;

  ImageDetailsBloc(this.fetchImageDetails) : super(ImageDetailsInitialState()) {
    on<ImageDetailsEvent>((event, emit) async {
      if (event is FetchImageDetailsEvent) {
        emit(ImageDetailsLoadingState());
        final response = await fetchImageDetails(event.id);
        response.fold((failure) {
          emit(const ImageDetailsErrorState(serverErrorMessage));
        }, (imageDetails) {
          emit(ImageDetailsLoadedState(imageDetails));
        });
      }
    });
  }
}
