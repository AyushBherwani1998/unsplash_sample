import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_sample/features/image_details/data/models/image_details_model.dart';
import 'package:unsplash_sample/features/image_details/domain/entities/image_details.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late final ImageDetailsModel detailsModel;

  setUpAll(() {
    detailsModel = const ImageDetailsModel(
      url: "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d",
      description: "A man drinking a coffee.",
      downloads: 1345,
      likes: 24,
      blurHash: 'LFC\$yHwc8^\$yIAS\$%M%00KxukYIp',
    );
  });

  test("ImageDetailsModel is subclass of ImageDetails", () {
    expect(detailsModel, isA<ImageDetails>());
  });

  test("ImageDetailsModel is created from json", () {
    final jsonMap = Map<String, dynamic>.from(
      jsonDecode(fixture('image_details_fixture.json')) as Map,
    );

    final imageDetailsModel = ImageDetailsModel.fromJson(jsonMap);

    expect(imageDetailsModel, detailsModel);
  });
}
