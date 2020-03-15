import 'dart:convert';

import 'package:flutter_clean_architecture/core/error/exception.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl numberTriviaRemoteDataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    numberTriviaRemoteDataSourceImpl =
        NumberTriviaRemoteDataSourceImpl(httpClient: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('trivia.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockHttpClient.get(
          'http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await numberTriviaRemoteDataSourceImpl
            .getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      'should preform a GET request on a URL with *random* endpoint with application/json header',
      () {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();
        // assert
        verify(mockHttpClient.get(
          'http://numbersapi.com/random',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result =
            await numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
