import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final result = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);

    if (result == null) {
      throw CacheException();
    }

    final numberTriviaModel = NumberTriviaModel.fromJson(json.decode(result));

    return numberTriviaModel;
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA, json.encode(triviaToCache.toJson()));
  }
}
