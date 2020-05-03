import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';
part 'details_store.g.dart';

class DetailsStore = _DetailsStoreBase with _$DetailsStore;

abstract class _DetailsStoreBase with Store {
  final GetBackDropsService _getBackDrops;

  _DetailsStoreBase({@required GetBackDropsService getBackDrops})
      : _getBackDrops = getBackDrops;

  @observable
  Movie detailedMovie;
  @action
  Future getBackdrops() async {
    Result<Movie> getBackdropRes = await _getBackDrops(detailedMovie);

    if (getBackdropRes is Success) {
      detailedMovie = getBackdropRes.data;
    } else {
      setGetBackdropsErrorMsg(getBackdropRes.error.message);
    }
  }

  @action
  void setDetailedMovie(Movie initMovie) {
    detailedMovie = initMovie;
  }

  @observable
  String getBackdropsErrorMsg;
  @action
  void setGetBackdropsErrorMsg(String msg) {
    getBackdropsErrorMsg = msg;
  }
}
