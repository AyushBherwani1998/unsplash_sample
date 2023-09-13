import 'package:dartz/dartz.dart';
import 'package:unsplash_sample/core/error/error.dart';

abstract class Usecase<T, P> {
  Future<Either<CustomError, T>> call(P params);
}
