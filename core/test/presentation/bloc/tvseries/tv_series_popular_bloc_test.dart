import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/presentation/bloc/bloc/popular_tvseries_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvseriesBloc popularTvseriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvseriesBloc = PopularTvseriesBloc(mockGetPopularTvSeries);
  });

  test('PopularTvSeriesEmpty initial state should be empty', () {
    expect(popularTvseriesBloc.state, PopularTvSeriesEmpty());
  });

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'should PopularTvSeriesLoading state emit and then PopularTvSeriesHasData state when data is success fetching data',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(PopularTvSeriesListener()),
    expect: () => <PopularTvseriesState>[
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(testTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetPopularTvSeries.execute()),
  );

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'should PopularTvSeriesLoading state emit and then PopularTvSeriesError state when data is unsuccess fetched..',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(PopularTvSeriesListener()),
    expect: () => <PopularTvseriesState>[
      PopularTvSeriesLoading(),
      const PopularTvSeriesErorr('Server Failure'),
    ],
    verify: (bloc) => PopularTvSeriesLoading(),
  );

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'should PopularTvSeriesLoading state emit and then PopularTvSeriesEmpty state when data is empty..',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(PopularTvSeriesListener()),
    expect: () => <PopularTvseriesState>[
      PopularTvSeriesLoading(),
      PopularTvSeriesEmpty(),
    ],
  );
}
