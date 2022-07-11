import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/presentation/bloc/bloc/tv_series_detail_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  const testId = 1;

  setUp(() {
    
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
  });

  test('the TvSeriesDetailBloc initial state should be empty ', () {
    expect(tvSeriesDetailBloc.state, TvSeriesDetailEmpty());
  });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'should TvSeriesDetailLoading state emit and TvSeriesDetailError when data is unsuccess to fetching data',
    
    build: () {
      when(mockGetTvSeriesDetail.execute(testId))
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    
    act: (bloc) => bloc.add(TvSeriesDetailListener(testId)),
    
    expect: () => <TvSeriesDetailState>[
      TvSeriesDetailLoading(),
      TvSeriesDetailError('Server Failure'),
    ],

    verify: (bloc) => TvSeriesDetailLoading(),
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should  TvSeriesDetailLoading state emit and then TvSeriesDetailHasData state when data is success fetching data',
      build: () {
        when(mockGetTvSeriesDetail.execute(testId))
            .thenAnswer((_) async =>  Right(testTvSeriesDetail));
        return tvSeriesDetailBloc;
      },

      act: (bloc) => bloc.add(TvSeriesDetailListener(testId)),

      expect: () => <TvSeriesDetailState>[

            TvSeriesDetailLoading(),
            TvSeriesDetailHasData(testTvSeriesDetail),
        
          ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(testId));
        return TvSeriesDetailListener(testId).props;
      });

  
}
