part of 'unsplash_image_bloc.dart';

abstract class UnsplashImageState extends Equatable {
  const UnsplashImageState();

  @override
  List<Object> get props => [];
}

class UnsplashImageInitialState extends UnsplashImageState {}

class UnsplashImageLoadingState extends UnsplashImageState {}

class UnsplashImagePaginatedLoadingState extends UnsplashImageState {}

class UnsplashImageLoadedState extends UnsplashImageState {
  final List<UnsplashImage> images;

  const UnsplashImageLoadedState(this.images);

  @override
  List<Object> get props => [images];
}

class UnsplashImageErrorState extends UnsplashImageState {
  final String errorMessage;

  const UnsplashImageErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class UnsplashImagePaginatedErrorState extends UnsplashImageState {
  final String errorMessage;

  const UnsplashImagePaginatedErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
