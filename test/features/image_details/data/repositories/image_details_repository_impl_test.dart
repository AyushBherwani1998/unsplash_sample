import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/error/error.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';
import 'package:unplash_sample/features/image_details/data/datasources/image_details_remote_datasource.dart';
import 'package:unplash_sample/features/image_details/data/models/image_details_model.dart';
import 'package:unplash_sample/features/image_details/data/repositories/image_details_repository_impl.dart';
import 'package:unplash_sample/features/image_details/domain/entities/image_details.dart';
import 'package:unplash_sample/features/image_details/domain/repositories/image_details_repository.dart';

import '../../../../core/mocks/image_details_remote_datasource.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  group("ImageDetailsRepositoryImpl tests", () {
    late final ImageDetailsRepositoryIml repositoryIml;
    late final ImageDetailsRemoteDataSource dataSource;
    late final ImageDetailsModel imageDetailsModel;

    setUpAll(() {
      dataSource = ImageDetailsRemoteSourceMock();
      repositoryIml = ImageDetailsRepositoryIml(dataSource);
      imageDetailsModel = ImageDetailsModel.fromJson(
        jsonDecode(fixture('image_details_fixture.json')),
      );
    });

    test('should return Image details upon success', () async {
      when(() => dataSource.fetchImageDetails(any()))
          .thenAnswer((invocation) async {
        return imageDetailsModel;
      });

      final result = await repositoryIml.fetchImageDetails("id");

      result.fold((failure) {
        expect(failure, isNull);
      }, (imageDetails) {
        expect(imageDetails, imageDetailsModel);
      });
    });

    test('should return ServerError upon failure', () async {
      when(() => dataSource.fetchImageDetails(any()))
          .thenThrow(Exception(serverErrorMessage));

      final result = await repositoryIml.fetchImageDetails("id");

      result.fold((failure) {
        expect(failure, isA<ServerError>());
      }, (imageDetails) {
        expect(imageDetails, isNull);
      });
    });
  });
}
