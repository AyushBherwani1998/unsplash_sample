part of 'image_details_bloc.dart';

abstract class ImageDetailsEvent extends Equatable {
  const ImageDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchImageDetailsEvent extends ImageDetailsEvent {
  final String id;

  const FetchImageDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}
