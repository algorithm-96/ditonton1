
import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/bloc/popular_tvseries_bloc.dart';
import 'package:core/presentation/bloc/bloc/recommend_tvseries_bloc.dart';
import 'package:core/presentation/bloc/bloc/top_rated_tv_series_bloc.dart';
import 'package:core/presentation/bloc/bloc/tv_series_detail_bloc.dart';
import 'package:core/presentation/bloc/bloc/tv_series_now_playing_bloc.dart';
import 'package:core/presentation/bloc/bloc/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/bloc/watchlist_tv_series_bloc.dart';
import 'package:mockito/mockito.dart';

class FakeTvSeriesNowPlayingBloc extends MockBloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState> implements TvSeriesNowPlayingBloc{}

class FakeTvSeriesNowPlayingState extends Fake implements TvSeriesNowPlayingState{}

class FakeTvSeriesNowPlayingEvent extends Fake implements TvSeriesNowPlayingEvent {}

class FakeTopRateTvSeriesBloc extends MockBloc<TopRateTvSeriesEvent, TopRateTvSeriesState> implements TopRateTvSeriesBloc{}

class FakeTopRateTvSeriesState extends Fake implements TopRateTvSeriesState{}

class FakeTopRateTvSeriesEvent extends Fake implements TopRateTvSeriesEvent{}

class FakeTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class FakeWatchlistTvSeriesEvent extends Fake
    implements WatchlistMovieEvent {}

class FakeWatchlistTvSeriesState extends Fake
    implements WatchlistTvSeriesState {}

class FakeWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

class FakePopularTvSeriesBloc extends MockBloc<PopularTvseriesEvent, PopularTvseriesState> implements PopularTvseriesBloc{}

class FakePopularTvSeriesState extends Fake implements PopularTvseriesState{}

class FakePopularTvSeriesEvent extends Fake implements PopularTvseriesEvent{}

class FakeRecommendTvSeriesBloc extends MockBloc<RecommendTvseriesEvent, RecommendTvseriesState> implements RecommendTvseriesBloc{}

class FakeRecommendTvSeriesState extends Fake implements RecommendTvseriesState{}

class FakeRecommendTvSeriesEvent extends Fake implements RecommendTvseriesEvent{}

class FakeTvSeriesDetailEvent extends Fake implements TvSeriesDetailEvent {}

class FakeTvSeriesDetailState extends Fake implements TvSeriesDetailState {}


