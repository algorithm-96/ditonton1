import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMovieBloc nowPlayingMovieBloc;

   setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);

  });

  test('initial state the NowPlayingMovieBloc should be empty ', () {
    expect(nowPlayingMovieBloc.state, NowPlayingMovieEmpty());
  });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'should NowPlayingMovieLoading state emit and then NowPlayingMovieHasData state when data is success fetching data',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(NowPlayingMovieListener()),
      expect: () => <NowPlayingMovieState>[
            NowPlayingMovieLoading(),
            NowPlayingMovieHasData(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
        return NowPlayingMovieListener().props;
      });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'should NowPlayingMovieLoading state emits and then NowPlayingMovieError state when data is unsuccess fetching data',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(NowPlayingMovieListener()),
    expect: () => <NowPlayingMovieState>[
      NowPlayingMovieLoading(),
      NowPlayingMovieError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingMovieLoading(),
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'should NowPlayingMovieLoading state emits and then NowPlayingMovieEmpty state when data is empty',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(NowPlayingMovieListener()),
    expect: () => <NowPlayingMovieState>[
      NowPlayingMovieLoading(),
      NowPlayingMovieEmpty(),
    ],
  );
}
