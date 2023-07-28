import 'package:equatable/equatable.dart';

abstract class CustomError extends Equatable {
  final List properties;

  const CustomError([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [properties];
}

class ServerError extends CustomError {}
