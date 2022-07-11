import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../bloc/bloc/recommend_tvseries_bloc.dart';
import '../../bloc/bloc/tv_series_detail_bloc.dart';
import '../../bloc/bloc/watchlist_tv_series_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_tvseries';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(TvSeriesDetailListener(widget.id));
      context
          .read<RecommendTvseriesBloc>()
          .add(RecommendTvSeriesListener(widget.id));
      context
          .read<WatchlistTvSeriesBloc>()
          .add((FetchWatchlistTvStatus(widget.id)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchlistTv =
        context.select<WatchlistTvSeriesBloc, bool>((bloc) {
      if (bloc.state is WatchlistTvSeriesIsAdded) {
        return (bloc.state as WatchlistTvSeriesIsAdded).isAdded;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesDetailHasData) {
            final tvseries = state.result;
            return SafeArea(
              child: DetailContent(
                tvseries,
                isAddedToWatchlistTv,
              ),
            );
          } else {
            return const Text("Failed to fetch data");
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TvSeriesDetail detail;
  bool addedWatchlist;

  DetailContent(this.detail, this.addedWatchlist, {Key? key}) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.detail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.detail.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.addedWatchlist) {
                                  context.read<WatchlistTvSeriesBloc>().add(
                                      SaveTvSeriesToWatchlist(widget.detail));
                                } else {
                                  context.read<WatchlistTvSeriesBloc>().add(
                                      DeleteTvSeriesFromWatchlist(
                                          widget.detail));
                                }
                                print(widget.addedWatchlist);
                                String message = "";
                                const watchlistAddSuccessMessage =
                                    'Added to Watchlist';
                                const watchlistRemoveSuccessMessage =
                                    'Removed from Watchlist';

                                final state =
                                    BlocProvider.of<WatchlistTvSeriesBloc>(
                                            context)
                                        .state;

                                if (state is WatchlistTvSeriesIsAdded) {
                                  final added = state.isAdded;
                                  message = added == false
                                      ? watchlistAddSuccessMessage
                                      : watchlistRemoveSuccessMessage;
                                } else {
                                  message = !widget.addedWatchlist
                                      ? watchlistAddSuccessMessage
                                      : watchlistRemoveSuccessMessage;
                                }
                                if (message == watchlistAddSuccessMessage ||
                                    message == watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(message),
                                          duration: const Duration(
                                            milliseconds: 1000,
                                          )));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                                setState(() {
                                  widget.addedWatchlist =
                                      !widget.addedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.addedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showDuration(widget.detail.episodeRunTime[0]),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.detail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.detail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.detail.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendTvseriesBloc,
                                RecommendTvseriesState>(
                              builder: (context, state) {
                                if (state is RecommendTvseriesLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendTvseriesError) {
                                  return Text(state.message);
                                } else if (state is RecommendTvseriesHasData) {
                                  final recommendTv = state.result;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = recommendTv[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendTv.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
