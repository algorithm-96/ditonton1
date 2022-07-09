import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late DetailMovieBloc detailMovieBloc;

  const testId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });
  test('initial state the DetailMovieBloc should be empty', () {
    expect(detailMovieBloc.state, DetailMovieEmpty());
  });

  blocTest<DetailMovieBloc, DetailMovieState>(
    
    'should  MovieDetailLoading state emit and MovieDetailError when bloc is unsuccess to fetch data.',
    build: () {

      when(mockGetMovieDetail.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },

    act: (bloc) => bloc.add(DetailMovieListener(testId)),

    expect: () => <DetailMovieState>[
      DetailMovieLoading(),
      DetailMovieError('Server Failure'),
    ],
    
    verify: (bloc) => DetailMovieLoading(),
  );

  blocTest<DetailMovieBloc, DetailMovieState>(

      'should MovieDetailLoading state emit and then MovieDetailHasData state when data is success fetching data.',
      build: () {

        when(mockGetMovieDetail.execute(testId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(DetailMovieListener(testId)),

      expect: () => <DetailMovieState>[
            DetailMovieLoading(),
            DetailMovieHasData(testMovieDetail),
          ],

      verify: (bloc) {
        verify(mockGetMovieDetail.execute(testId));
        return DetailMovieListener(testId).props;
      });

  
}