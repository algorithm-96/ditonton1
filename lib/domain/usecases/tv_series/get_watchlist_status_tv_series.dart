import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchListStatusTvSeries {
  final TvSeriesRepo repository;

  GetWatchListStatusTvSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.addToWatchListTvSeries(id);
  }
}
