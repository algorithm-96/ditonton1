import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_series_model/tv_series_data_table.dart';


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
    // TODO: implement getTvSeriesById
    final result = await databaseHelperTvSeries.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesDataTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesDataTable>> getWatchlistTvSeries() async {
    // TODO: implement getWatchlistTvSeries
    final result = await databaseHelperTvSeries.getWatchlistTvSeries();
    return result.map((e) => TvSeriesDataTable.fromMap(e)).toList();
  }

  @override
  Future<String> saveWatchlistTvSeries(
      TvSeriesDataTable tvSeriesDataTable) async {
    // TODO: implement saveWatchlistTvSeries
    try {
      await databaseHelperTvSeries.saveWatchlistTvSeries(tvSeriesDataTable);
      return 'Save to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
