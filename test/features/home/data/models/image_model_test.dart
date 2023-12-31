import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash_sample/features/home/data/models/image_model.dart';
import 'package:unsplash_sample/features/home/domain/entities/image.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group("image model tests", () {
    const unsplashImageModel = UnsplashImageModel(
      id: "LBI7cgq3pbM",
      url:
          "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=400&fit=max",
      blurHash: "LoC%a7IoIVxZ_NM|M{s:%hRjWAo0",
      likes: 12,
      userName: "poorkane",
      profileImage:
          "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=32&w=32",
    );
    test("UnsplashImageModel is subclass of UnsplashImage", () {
      expect(unsplashImageModel, isA<UnsplashImage>());
    });

    test('UnsplashImageModelList is created from json string', () {
      final map = List<Map<String, dynamic>>.from(
        jsonDecode(fixture('image_model_fixture.json')) as List,
      );

      final result = UnsplashImageListModel.fromJson(map);

      expect(result.images, [unsplashImageModel]);
    });
  });
}
