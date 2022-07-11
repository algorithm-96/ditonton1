
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/popular_tvseries_bloc.dart';
import '../../widgets/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';
  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularTvseriesBloc>().add(PopularTvSeriesListener());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvseriesBloc, PopularTvseriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvSeriesHasData) {
              final data = state.results;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final popular = data[index];
                  return TvSeriesCard(popular);
                },
                itemCount: data.length,
              );
            } else {
              return Center(
                key: const Key('error'),
                child: Text((state as PopularTvSeriesErorr).message),
              );
            }
          },
        ),
      ),
    );
  }
}
