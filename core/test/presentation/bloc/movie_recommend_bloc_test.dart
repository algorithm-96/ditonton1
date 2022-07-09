import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommend_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendMovieBloc recommendMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  const testId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendMovieBloc =
        RecommendMovieBloc(mockGetMovieRecommendations);
  });

  test('the RecommendMovieEmpty initial state should be empty ', () {
    expect(recommendMovieBloc.state, RecommendMovieEmpty());
  });

  blocTest<RecommendMovieBloc, RecommendMovieState>(
    'should PopularMovieLoading state emits and then PopularMovieHasData state when data is success fetching data',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return recommendMovieBloc;
    },
    act: (bloc) => bloc.add(RecommendMovieListener(testId)),
    expect: () => <RecommendMovieState>[
      RecommendMovieLoading(),
      RecommendMovieHasData(testMovieList),
    ],
    verify: (bloc) => verify(mockGetMovieRecommendations.execute(testId)),
  );

  blocTest<RecommendMovieBloc, RecommendMovieState>(
    'should RecommendMovieLoading state emit and then RecommendMovieEmpty state when data is empty..',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return recommendMovieBloc;
    },
    act: (bloc) => bloc.add(RecommendMovieListener(testId)),
    expect: () => <RecommendMovieState>[
      RecommendMovieLoading(),
      RecommendMovieEmpty(),
    ],
  );

  blocTest<RecommendMovieBloc, RecommendMovieState>(
    'should RecommendMovieLoading state emits and then RecommendMovieError state when data is unsuccess fetched',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendMovieBloc;
    },
    act: (bloc) => bloc.add(RecommendMovieListener(testId)),
    expect: () => <RecommendMovieState>[
      RecommendMovieLoading(),
      RecommendMovieError('Server Failure'),
    ],
    verify: (bloc) => RecommendMovieLoading(),
  );

  
}
