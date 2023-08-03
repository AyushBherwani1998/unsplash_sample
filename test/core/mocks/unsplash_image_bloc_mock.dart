import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';

class UnsplashImageBlocMock extends Mock implements UnsplashImageBloc {}

class UnsplashImageFakeState extends Fake implements UnsplashImageState {}
