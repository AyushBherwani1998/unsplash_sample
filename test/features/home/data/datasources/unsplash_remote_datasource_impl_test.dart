import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/features/home/data/datasources/unsplash_remote_datasource.dart';
import 'package:unplash_sample/features/home/data/models/image_model.dart';

import '../../../../core/mocks/dio_mock.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: './lib/core/.env');

  late final DioMock dioMock;
  late final UnsplashImageListModel unsplashImageModel;
  late final UnsplashRemoteDataSourceImpl unsplashRemoteDataSourceImpl;
  late final List<Map<String, dynamic>> jsonData;

  setUpAll(() async {
    dioMock = DioMock();
    jsonData = List<Map<String, dynamic>>.from(
      jsonDecode(fixture('image_model_fixture.json')) as List,
    );
    unsplashImageModel = UnsplashImageListModel.fromJson(jsonData);

    unsplashRemoteDataSourceImpl = UnsplashRemoteDataSourceImpl(dioMock);
  });

  group('UnsplashRemoteDataSourceImpl tests', () {
    test('should return UnsplashImageModel upon success', () async {
      when(
        () => dioMock.get<List>(
          any(),
          queryParameters: any(named: "queryParameters"),
          options: any(named: "options"),
        ),
      ).thenAnswer((invocation) async {
        return Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: jsonData,
        );
      });

      final response = await unsplashRemoteDataSourceImpl.fetchImages(1, 10);

      expect(unsplashImageModel.images, response);
    });

    test('should return Exception upon failure', () async {
      when(() => dioMock.get<List>(
            any(),
            queryParameters: any(named: "queryParameters"),
            options: any(named: "options"),
          )).thenThrow(
        DioException(requestOptions: RequestOptions()),
      );

      final fetchImageFunction = unsplashRemoteDataSourceImpl.fetchImages;

      expect(
        () => fetchImageFunction.call(1, 10),
        throwsA(const TypeMatcher<Exception>()),
      );
    });
  });
}
