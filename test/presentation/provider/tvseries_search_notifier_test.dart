import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:ditonton/presentation/provider/search_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvNotifier searchTvNotifier;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listener;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    listener = 0;
    searchTvNotifier = SearchTvNotifier(searchTv: mockSearchTvSeries)
      ..addListener(() {
        listener += 1;
      });
  });

  final testTv = TvSeries(
    voteCount: 1,
    voteAverage: 5,
    backdropPath: 'backdropPath',
    posterPath: 'posterPath',
    popularity: 1,
    overview:
        "Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show's 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio.",
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: const ['US'],
    name: 'name',
    id: 1,
    genreIds: const [1],
    firstAirDate: 'firstAirDate',
  );

  final testTvSeries = <TvSeries>[testTv];

  final testQuery = 'superman';

group('search tv series', () {
    test('should change state to loading when usecase is called', () async {

      // arrange
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => Right(testTvSeries));

      // act
      searchTvNotifier.fetchSearchTv(testQuery);
      
      // assert
      expect(searchTvNotifier.state, RequestState.Loading);
    });

    test('should change search result data when data is got successfully',
        () async {

      // arrange
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => Right(testTvSeries));

      // act
      await searchTvNotifier.fetchSearchTv(testQuery);

      // assert
      expect(searchTvNotifier.state, RequestState.Loaded);
      expect(searchTvNotifier.searchTvResult, testTvSeries);
      expect(listener, 2);
    });

    test('should return error when data is unsuccessful', () async {

      // arrange
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await searchTvNotifier.fetchSearchTv(testQuery);

      // assert
      expect(searchTvNotifier.state, RequestState.Error);
      expect(searchTvNotifier.message, 'Server Failure');
      expect(listener, 2);
    });
  });

}
