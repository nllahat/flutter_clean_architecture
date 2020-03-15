import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/number_trivia.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  NumberTriviaState([List props = const <dynamic>[]]) : super();
}

class Empty extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  Loaded({@required this.trivia}) : super([trivia]);

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message}) : super([message]);

  @override
  List<Object> get props => [message];
}