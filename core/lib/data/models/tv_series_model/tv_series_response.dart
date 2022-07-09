
import 'package:equatable/equatable.dart';

import 'tv_series_model.dart';

class TvSeriesResponse extends Equatable{
  final List<TvModel> result;
  TvSeriesResponse({required this.result});

  factory TvSeriesResponse.fromJson(Map<String,dynamic> json) =>
      TvSeriesResponse(
        result: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.posterPath != null )),
      );
  Map<String,dynamic> toJson() =>{
    "results": List<dynamic>.from(result.map((e) => e.toJson())),
  };

  @override
  List<Object> get props => [result];

}