
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tvseries_popular_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvNotifier popularTvNotifier;
  late int listener;

  setUp(() {

    listener = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvNotifier = PopularTvNotifier(mockGetPopularTvSeries)
      ..addListener(() {
        listener++;
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

final testTvseries = <TvSeries>[testTv];
test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(testTvseries));
        
    // act
    await popularTvNotifier.fetchingPopularTvSeries();
    // assert
    expect(popularTvNotifier.state, RequestState.Loaded);
    expect(popularTvNotifier.tvSeriesPopular, testTvseries);
    expect(listener, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange

    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act

    await popularTvNotifier.fetchingPopularTvSeries();
    // assert
    
    expect(popularTvNotifier.state, RequestState.Error);
    expect(popularTvNotifier.message, 'Server Failure');
    expect(listener, 2);
  });
test('should change state to loading when usecase is called', () async {

    // arrange
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(testTvseries));

    // act
    popularTvNotifier.fetchingPopularTvSeries();

    // assert
    expect(popularTvNotifier.state, RequestState.Loading);
    expect(listener, 1);
  });

  
}



