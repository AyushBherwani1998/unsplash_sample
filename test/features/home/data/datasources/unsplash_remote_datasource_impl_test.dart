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
  late final UnsplashImageModel unsplashImageModel;
  late final UnsplashRemoteDataSourceImpl unsplashRemoteDataSourceImpl;
  late final Map<String, dynamic> jsonMap;

  setUpAll(() {
    dioMock = DioMock();
    jsonMap = jsonDecode(fixture('image_model_fixture.json'));
    unsplashImageModel = UnsplashImageModel.fromJson(jsonMap);

    unsplashRemoteDataSourceImpl = UnsplashRemoteDataSourceImpl(dioMock);
  });

  group('UnsplashRemoteDataSourceImpl tests', () {
    test('should return UnsplashImageModel upon success', () async {
      when(() => dioMock.get(any())).thenAnswer((invocation) async {
        return Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: [jsonMap],
        );
      });

      final response = await unsplashRemoteDataSourceImpl.fetchImages(1);

      expect([unsplashImageModel], response);
    });
  });
  
}
