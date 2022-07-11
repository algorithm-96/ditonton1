import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommend.dart';
import 'package:core/presentation/bloc/bloc/recommend_tvseries_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_recommend_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommend])
void main() {

  late RecommendTvseriesBloc recommendTvseriesBloc;
  late MockGetTvSeriesRecommend mockGetTvSeriesRecommend;
  const testId = 1;

  setUp(() {
    mockGetTvSeriesRecommend = MockGetTvSeriesRecommend();
    recommendTvseriesBloc = RecommendTvseriesBloc(mockGetTvSeriesRecommend);
  });

  test('initial state RecommendTvseriesBloc should be empty', () {
    expect(recommendTvseriesBloc.state, RecommendTvseriesEmpty());
  });

  blocTest<RecommendTvseriesBloc, RecommendTvseriesState>(
    'should PopularTvSeriesLoading state emit then PopularTvSeriesHasData state when data is success fetching',
    
    build: () {
      when(mockGetTvSeriesRecommend.execute(testId))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return recommendTvseriesBloc;
    },
    
    act: (bloc) => bloc.add(RecommendTvSeriesListener(testId)),

    expect: () => <RecommendTvseriesState>[
      RecommendTvseriesLoading(),
      RecommendTvseriesHasData(testTvSeriesList),
    ],
    
    verify: (bloc) => verify(mockGetTvSeriesRecommend.execute(testId)),
  );

  blocTest<RecommendTvseriesBloc, RecommendTvseriesState>(
    'should RecommendTvseriesLoading state emit then RecommendTvseriesEmpty state when data is empty',
    
    build: () {
      when(mockGetTvSeriesRecommend.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return recommendTvseriesBloc;
    },
    
    act: (bloc) => bloc.add(RecommendTvSeriesListener(testId)),

    expect: () => <RecommendTvseriesState>[
      RecommendTvseriesLoading(),
      RecommendTvseriesEmpty()    ],
    
    verify: (bloc) => verify(mockGetTvSeriesRecommend.execute(testId)),
  );

blocTest<RecommendTvseriesBloc, RecommendTvseriesState>(
    'should RecommendTvseriesLoading state emit then RecommendTvseriesError state when data is unsuccess fetching',
    
    build: () {
      when(mockGetTvSeriesRecommend.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendTvseriesBloc;
    },
    
    act: (bloc) => bloc.add(RecommendTvSeriesListener(testId)),

    expect: () => <RecommendTvseriesState>[
      RecommendTvseriesLoading(),
      RecommendTvseriesError('Server Failure'),
    ],
    
    verify: (bloc) => RecommendTvseriesLoading(),
  );
  

  


}
