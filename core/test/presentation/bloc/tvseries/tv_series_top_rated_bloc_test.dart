import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/presentation/bloc/bloc/top_rated_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRateTvSeries])
void main() {
  late TopRateTvSeriesBloc topRateTvSeriesBloc;
  late MockGetTopRateTvSeries mockGetTopRateTvSeries;

  setUp(() {
     mockGetTopRateTvSeries = MockGetTopRateTvSeries();
    topRateTvSeriesBloc = TopRateTvSeriesBloc(mockGetTopRateTvSeries);
   
  });

  test('initial state TopRateTvSeriesEmpty should be empty', () {
    expect(topRateTvSeriesBloc.state, TopRateTvSeriesEmpty());
  });

  blocTest<TopRateTvSeriesBloc, TopRateTvSeriesState>(
    'should  PopularTvseriesLoading state emit and then PopularTvseriesHasData state when data is success fetching data',
    build: () {
      when(mockGetTopRateTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return topRateTvSeriesBloc;
    },
    act: (bloc) => bloc.add(TopRateTvSeriesListener()),
    expect: () => <TopRateTvSeriesState>[
      TopRateTvSeriesLoading(),
      TopRatedTvSeriesHasData(testTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetTopRateTvSeries.execute()),
  );

  blocTest<TopRateTvSeriesBloc, TopRateTvSeriesState>(
    'should TopRateTvSeriesLoading state emit and then TopRateTvSeriesEmpty state when data is empty..',
    build: () {
      when(mockGetTopRateTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return topRateTvSeriesBloc;
    },
    act: (bloc) => bloc.add(TopRateTvSeriesListener()),
    expect: () => <TopRateTvSeriesState>[
      TopRateTvSeriesLoading(),
      TopRateTvSeriesEmpty(),
    ],
  );

  blocTest<TopRateTvSeriesBloc, TopRateTvSeriesState>(
    'should  TopRatedTvseriesLoading state emit and then TopRatedTvseriesError state when data is unsuccess fetched..',
    build: () {
      when(mockGetTopRateTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRateTvSeriesBloc;
    },
    act: (bloc) => bloc.add(TopRateTvSeriesListener()),
    expect: () => <TopRateTvSeriesState>[
      TopRateTvSeriesLoading(),
      TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => TopRateTvSeriesLoading(),
  );
}
