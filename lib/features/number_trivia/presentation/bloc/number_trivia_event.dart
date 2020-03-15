import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString) : super();
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
