


import 'package:core/utils/exception.dart';

import '../models/tv_series_model/tv_series_data_table.dart';
import 'db/database_helper.dart';

abstract class TvSeriesLocalData {
  Future<String> saveWatchlistTvSeries(TvSeriesDataTable tvSeriesDataTable);
  Future<String> deleteWatchlistTvSeries(TvSeriesDataTable tvSeriesDataTable);
  Future<List<TvSeriesDataTable>> getWatchlistTvSeries();
  Future<TvSeriesDataTable?> getTvSeriesById(int id);
}

class TvSeriesLocalDataImpl implements TvSeriesLocalData {
  final DatabaseHelper databaseHelperTvSeries;
  TvSeriesLocalDataImpl({required this.databaseHelperTvSeries});

  @override
  Future<String> deleteWatchlistTvSeries(

  
      TvSeriesDataTable tvSeriesDataTable) async {
    try {
      await databaseHelperTvSeries.deleteWatchlistTvSeries(tvSeriesDataTable);
      return 'Delete from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesDataTable?> getTvSeriesById(int id) async {


    final result = await databaseHelperTvSeries.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesDataTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesDataTable>> getWatchlistTvSeries() async {


    final result = await databaseHelperTvSeries.getWatchlistTvSeries();
    return result.map((e) => TvSeriesDataTable.fromMap(e)).toList();
  }

  @override
  Future<String> saveWatchlistTvSeries(
      TvSeriesDataTable tvSeriesDataTable) async {
    

    try {
      await databaseHelperTvSeries.saveWatchlistTvSeries(tvSeriesDataTable);
      return 'Save to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
