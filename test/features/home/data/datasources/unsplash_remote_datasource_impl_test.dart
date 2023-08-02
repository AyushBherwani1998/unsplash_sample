import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/features/home/data/datasources/unsplash_remote_datasource.dart';
import 'package:unplash_sample/features/home/data/models/image_model.dart';

import '../../../../core/mocks/dio_mock.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late final DioMock dioMock;
  late final UnsplashImageListModel unsplashImageModel;
  late final UnsplashRemoteDataSourceImpl unsplashRemoteDataSourceImpl;
  late final dynamic jsonData;

  setUpAll(() {
    dioMock = DioMock();
    jsonData = jsonDecode(fixture('image_model_fixture.json'));
    unsplashImageModel = UnsplashImageListModel.fromJson(
      List<Map<String, dynamic>>.from(jsonData),
    );

    unsplashRemoteDataSourceImpl = UnsplashRemoteDataSourceImpl(dioMock);
  });

  group('UnsplashRemoteDataSourceImpl tests', () {
    test('should return UnsplashImageModel upon success', () async {
      when(() => dioMock.get(any())).thenAnswer((invocation) async {
        return Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: jsonData,
        );
      });

      final response = await unsplashRemoteDataSourceImpl.fetchImages(1);

      expect(unsplashImageModel.images, response);
    });

    test('should return Exception upon failure', () async {
      when(() => dioMock.get(any())).thenThrow(
        DioException(requestOptions: RequestOptions()),
      );

      final fetchImageFunction = unsplashRemoteDataSourceImpl.fetchImages;

      expect(
        () => fetchImageFunction.call(1),
        throwsA(const TypeMatcher<Exception>()),
      );
    });
  });
}
