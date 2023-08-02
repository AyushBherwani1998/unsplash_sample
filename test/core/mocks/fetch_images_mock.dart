import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/features/home/domain/usecases/fetch_images.dart';

class FetchImagesMock extends Mock implements FetchImages {}

class FakeFetchImageParams extends Fake implements FetchImageParams {}
