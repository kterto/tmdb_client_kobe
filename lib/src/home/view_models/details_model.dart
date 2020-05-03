import 'package:flutter/foundation.dart';
import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class DetailsModel extends BaseViewModel {
  final GetBackDropsService _getBackDrops;
  Result<Movie> detailedMovieRes;

  DetailsModel({@required GetBackDropsService getBackDrops})
      : _getBackDrops = getBackDrops;

  void initModel({@required Movie detailedMovie}) async {
    setState(ViewState.Busy);

    detailedMovieRes = await _getBackDrops(detailedMovie);

    setState(ViewState.Idle);
  }
}
