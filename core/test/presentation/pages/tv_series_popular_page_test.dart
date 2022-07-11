import 'package:core/presentation/bloc/bloc/popular_tvseries_bloc.dart';
import 'package:core/presentation/pages/tv_series_page/popular_tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_page_helper.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FakePopularTvSeriesBloc fakePopularTvSeriesBloc;

  setUpAll(() {
    fakePopularTvSeriesBloc = FakePopularTvSeriesBloc();
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());

  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvseriesBloc>(
      create: (_) => fakePopularTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() {
    fakePopularTvSeriesBloc.close();
  });

  testWidgets('Page should display circular progress indicator',
      (WidgetTester tester) async {
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(PopularTvSeriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });
}
