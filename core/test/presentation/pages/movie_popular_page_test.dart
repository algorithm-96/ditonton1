import 'package:core/presentation/bloc/bloc/popular_movie_bloc.dart';
import 'package:core/presentation/pages/movie_page/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'movie_now_playing_page_test.dart';

void main() {
  late FakePopularMoviesBloc fakePopularMoviesBloc;

    setUpAll(() {
    fakePopularMoviesBloc = FakePopularMoviesBloc();
    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => fakePopularMoviesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() {
    fakePopularMoviesBloc.close();
  });

  testWidgets('page should display circular progress indicator',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state).thenReturn(PopularMoviesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

}
