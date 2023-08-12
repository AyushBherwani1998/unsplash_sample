import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unplash_sample/core/error/error.dart';
import 'package:unplash_sample/core/utils/string_constants.dart';
import 'package:unplash_sample/features/image_details/data/models/image_details_model.dart';
import 'package:unplash_sample/features/image_details/domain/entities/image_details.dart';
import 'package:unplash_sample/features/image_details/domain/usecases/fetch_image_details.dart';
import 'package:unplash_sample/features/image_details/presentation/bloc/image_details_bloc.dart';

import '../../../../core/mocks/fetch_image_details_mock.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  group("ImageDetailsBloc tests", () {
    late final ImageDetailsBloc imageDetailsBloc;
    late final FetchImageDetails fetchImageDetails;
    late final ImageDetails imageDetails;

    setUpAll(() {
      fetchImageDetails = FetchImageDetailsMock();
      imageDetailsBloc = ImageDetailsBloc(fetchImageDetails);
      imageDetails = ImageDetailsModel.fromJson(
        Map<String, dynamic>.from(
          jsonDecode(fixture('image_details_fixture.json')) as Map,
        ),
      );
    });

    test("initial state should be ImageDetailsInitialState", () {
      expect(imageDetailsBloc.state, ImageDetailsInitialState());
    });

    test(
        'should emit [ImageDetailsLoadingState, ImageDetailsErrorState] on error',
        () {
      when(() => fetchImageDetails.call(any())).thenAnswer((_) async {
        return Left(ServerError());
      });

      imageDetailsBloc.add(const FetchImageDetailsEvent("id"));

      expectLater(
        imageDetailsBloc.stream,
        emitsInOrder([
          ImageDetailsLoadingState(),
          const ImageDetailsErrorState(serverErrorMessage)
        ]),
      );
    });

    test(
        'should emit [ImageDetailsLoadingState, ImageDetailsLoadedState] on success',
        () {
      when(() => fetchImageDetails.call(any())).thenAnswer((_) async {
        return Right(imageDetails);
      });

      imageDetailsBloc.add(const FetchImageDetailsEvent("id"));

      expectLater(
        imageDetailsBloc.stream,
        emitsInOrder([
          ImageDetailsLoadingState(),
          ImageDetailsLoadedState(imageDetails)
        ]),
      );
    });
  });
}
