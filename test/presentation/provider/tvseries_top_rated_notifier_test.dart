import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tvseries_top_rated_notifier_test.mocks.dart';

@GenerateMocks([GetTopRateTvSeries])
void main() {
  late MockGetTopRateTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvNotifier notifier;
  late int listener;

  setUp(() {
    listener = 0;
    mockGetTopRatedTvSeries = MockGetTopRateTvSeries();
    notifier = TopRatedTvNotifier(getTopRateTvSeries: mockGetTopRatedTvSeries)
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

  final testTvSeries = <TvSeries>[testTv];

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTvSeries.execute())
        .thenAnswer((_) async => Right(testTvSeries));
    // act
    await notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeriesTopRated, testTvSeries);
    expect(listener, 2);
  });

    test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listener, 2);
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTvSeries.execute())
        .thenAnswer((_) async => Right(testTvSeries));
    // act
    notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listener, 1);
  });


}