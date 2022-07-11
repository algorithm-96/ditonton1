import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/presentation/bloc/bloc/tv_series_now_playing_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetTvNowPlaying])
void main() {
  late MockGetTvNowPlaying mockGetTvNowPlaying;
  late TvSeriesNowPlayingBloc tvSeriesNowPlayingBloc;

  setUp(() {
    mockGetTvNowPlaying = MockGetTvNowPlaying();
    tvSeriesNowPlayingBloc = TvSeriesNowPlayingBloc(mockGetTvNowPlaying);
  });

  test('the TvSeriesNowPlayingBloc initial state should be empty ', () {
    expect(tvSeriesNowPlayingBloc.state, TvSeriesNowPlayingEmpty());
  });

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
      'should  TvSeriesNowPlayingLoading state emit and then TvSeriesNowPlayingHasData state when data is success fetching data',
      build: () {
        when(mockGetTvNowPlaying.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return tvSeriesNowPlayingBloc;
      },
      act: (bloc) => bloc.add(TvSeriesNowPlayingListener()),
      expect: () => <TvSeriesNowPlayingState>[
            TvSeriesNowPlayingLoading(),
            TvSeriesNowPlayingHasData(testTvSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetTvNowPlaying.execute());
        return TvSeriesNowPlayingListener().props;
      });

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
    'should TvSeriesNowPlayingLoading state emit and then TvSeriesNowPlayingEmpty state when data is empty..',
    build: () {
      when(mockGetTvNowPlaying.execute())
          .thenAnswer((_) async => const Right([]));
      return tvSeriesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(TvSeriesNowPlayingListener()),
    expect: () => <TvSeriesNowPlayingState>[
      TvSeriesNowPlayingLoading(),
      TvSeriesNowPlayingEmpty(),
    ],
  );

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
    'should TvSeriesNowPlayingLoading state emit and then TvSeriesNowPlayingError state when data is unsuccess fetched..',
    build: () {
      when(mockGetTvNowPlaying.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(TvSeriesNowPlayingListener()),
    expect: () => <TvSeriesNowPlayingState>[
      TvSeriesNowPlayingLoading(),
      TvSeriesNowPlayingError('Server Failure'),
    ],
    verify: (bloc) => TvSeriesNowPlayingLoading(),
  );
}
