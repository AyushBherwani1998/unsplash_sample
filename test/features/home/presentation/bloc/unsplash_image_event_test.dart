import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_sample/features/home/domain/usecases/fetch_images.dart';
import 'package:unsplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';

void main() {
  test('Validate FetchImageEvent equality', () {
    final params = FetchImageParams(1, 10);
    final event = FetchImageEvent(params);

    expect(event.props, [params.page, params.perPage]);
    expect(event, FetchImageEvent(params));
  });
}
