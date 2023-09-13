import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_sample/features/image_details/presentation/bloc/image_details_bloc.dart';

void main() {
  test('Validate FetchImageEvent equality', () {
    const id = "id";
    const event = FetchImageDetailsEvent(id);

    expect(event.props, [id]);
    expect(event, const FetchImageDetailsEvent(id));
  });
}
