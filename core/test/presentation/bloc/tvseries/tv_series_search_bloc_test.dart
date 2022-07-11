import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/search_tv_series.dart';
import 'package:core/presentation/bloc/bloc/search_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchBloc tvSeriesSearchBloc;
  late MockSearchTvSeries mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTvSeries();
    tvSeriesSearchBloc = TvSeriesSearchBloc(mockSearchTv);
  });

   final testTvModel = TvSeries(
        backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
        genreIds: const [10765, 18, 10759, 9648],
        id: 1399,
        originalName: 'Game of Thrones',
        overview:
            "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
        popularity: 369.594,
        posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
        firstAirDate: '2011-04-17',
        name: 'Game of Thrones',
        voteAverage: 8.3,
        voteCount: 11504, 
        originalLanguage: 'orginalLanguage', 
        originCountry: const ['originCountry']

    );

    final testTvSeriesList = <TvSeries>[testTvModel];
    const qTest = "Game of Thrones";

  test('initial state should be empty', () {

    expect(tvSeriesSearchBloc.state, SearchTvSeriesEmpty());
  
  });

  blocTest<TvSeriesSearchBloc, SearchTvSeriesState>(
    'Should emit SearchTvSeriesLoading and SearchTvSeriesError when get search is failed',
    build: () {
      when(mockSearchTv.execute(qTest))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesQueryChanged(qTest)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvSeriesLoading(),
      const SearchTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(qTest));
    },
  );


   blocTest<TvSeriesSearchBloc, SearchTvSeriesState>(
    'Should emit SearchTvSeriesLoading and SearchTvSeriesHasData when data is got success',
    build: () {
      when(mockSearchTv.execute(qTest))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesQueryChanged(qTest)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(qTest));
    },
  );

  


}
