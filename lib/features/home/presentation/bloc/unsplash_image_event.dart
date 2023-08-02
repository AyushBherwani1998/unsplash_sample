part of 'unsplash_image_bloc.dart';

abstract class UnsplashImageEvent extends Equatable {
  const UnsplashImageEvent();

  @override
  List<Object> get props => [];
}

class FetchImageEvent extends UnsplashImageEvent {
  final FetchImageParams params;

  const FetchImageEvent(this.params);

  @override
  List<Object> get props => [params.page, params.perPage];
}
