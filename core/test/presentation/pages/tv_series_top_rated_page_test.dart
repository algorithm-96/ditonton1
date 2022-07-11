import 'package:core/presentation/bloc/bloc/top_rated_tv_series_bloc.dart';
import 'package:core/presentation/pages/tv_series_page/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_page_helper.dart';

void main() {
  late FakeTopRateTvSeriesBloc fakeTopRateTvSeriesBloc;


  setUpAll(() {
    fakeTopRateTvSeriesBloc = FakeTopRateTvSeriesBloc();
    registerFallbackValue(FakeTopRateTvSeriesEvent());
    registerFallbackValue(FakeTopRateTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRateTvSeriesBloc>(
      create: (_) => fakeTopRateTvSeriesBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  tearDown(() => fakeTopRateTvSeriesBloc.close());

  testWidgets('page should display circular progress indicator ',
      
      (WidgetTester tester) async {
    
    when(() => fakeTopRateTvSeriesBloc.state)
    
        .thenReturn(TopRateTvSeriesLoading());

    
    final circularProgressIndicatorFinder =
    
        find.byType(CircularProgressIndicator);

    
    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));
    
    await tester.pump();
    
    expect(circularProgressIndicatorFinder, findsOneWidget);
  });
}
