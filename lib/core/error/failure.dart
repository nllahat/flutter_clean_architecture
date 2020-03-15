import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([List properties = const <dynamic>[]]);
}

// General failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => null;
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}