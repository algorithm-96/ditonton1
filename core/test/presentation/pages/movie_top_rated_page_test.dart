import 'package:core/presentation/bloc/bloc/top_rated_movie_bloc.dart';
import 'package:core/presentation/pages/movie_page/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'movie_now_playing_page_test.dart';

void main() {
  late FakeTopRatedMoviesBloc fakeTopRatedMoviesBloc;
  setUpAll(() {
    fakeTopRatedMoviesBloc = FakeTopRatedMoviesBloc();
    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>(
      create: (_) => fakeTopRatedMoviesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() => fakeTopRatedMoviesBloc.close());

  testWidgets('page should display circular progress indicator',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMovieLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });
}
