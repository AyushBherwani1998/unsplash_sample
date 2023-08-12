import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/features/image_details/data/datasources/image_details_remote_datasource.dart';
import 'package:unplash_sample/features/image_details/data/models/image_details_model.dart';

import '../../../../core/mocks/dio_mock.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: './lib/core/.env');

  late final DioMock dioMock;
  late final ImageDetailsModel imageDetailsModel;
  late final ImageDetailsRemoteDataSource imageDetailsRemoteDataSource;
  late final Map<String, dynamic> jsonData;

  setUpAll(() async {
    dioMock = DioMock();
    jsonData = Map<String, dynamic>.from(
      jsonDecode(fixture('image_details_fixture.json')) as Map,
    );
    imageDetailsModel = ImageDetailsModel.fromJson(jsonData);

    imageDetailsRemoteDataSource = ImageDetailsRemoteDataSourceImpl(dioMock);
  });

  group('ImageDetailsRemoteDataSourceImpl tests', () {
    test('should return ImageDetailsModel upon success', () async {
      when(
        () => dioMock.get<Map>(
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

      final response =
          await imageDetailsRemoteDataSource.fetchImageDetails("id");

      expect(imageDetailsModel, response);
    });

    test('should return Exception upon failure', () async {
      when(() => dioMock.get<Map>(
            any(),
            queryParameters: any(named: "queryParameters"),
            options: any(named: "options"),
          )).thenThrow(
        DioException(requestOptions: RequestOptions()),
      );

      final fetchImageDetailsFunction =
          imageDetailsRemoteDataSource.fetchImageDetails;

      expect(
        () => fetchImageDetailsFunction.call('id'),
        throwsA(const TypeMatcher<Exception>()),
      );
    });
  });
}
