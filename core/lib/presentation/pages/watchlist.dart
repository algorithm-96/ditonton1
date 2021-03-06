
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';

import 'watchlist_movies_page.dart';
import 'watchlist_tv_series_page.dart';

class Watchlist extends StatefulWidget {
  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist ditonton'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSubHeading(
              title: 'Watchlist Movie',
              onTap: () =>
                  Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSubHeading(
              title: 'Watchlist Tv Series',
              onTap: () =>
                  Navigator.pushNamed(context, WatchlistTvSeriesPage.ROUTE_NAME),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
