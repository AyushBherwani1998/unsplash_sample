part of 'image_details_bloc.dart';

abstract class ImageDetailsState extends Equatable {
  const ImageDetailsState();

  @override
  List<Object> get props => [];
}

class ImageDetailsInitialState extends ImageDetailsState {}

class ImageDetailsLoadingState extends ImageDetailsState {}

class ImageDetailsLoadedState extends ImageDetailsState {
  final ImageDetails imageDetails;

  const ImageDetailsLoadedState(this.imageDetails);
}

class ImageDetailsErrorState extends ImageDetailsState {
  final String errorMessage;

  const ImageDetailsErrorState(this.errorMessage);

}
