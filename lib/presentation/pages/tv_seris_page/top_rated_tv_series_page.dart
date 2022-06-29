import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';
  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}



class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvNotifier>(context, listen: false)
            .fetchTopRatedTv());
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.tvSeriesTopRated[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.tvSeriesTopRated.length,
              );
            } else {
              return Center(
                key: Key('error'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}