import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_client_kobe/src/home/blocs/details/details_event.dart';
import 'package:tmdb_client_kobe/src/home/blocs/details/details_state.dart';

import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetBackDropsService _getBackDrops;

  DetailsBloc({@required GetBackDropsService getBackDrops})
      : _getBackDrops = getBackDrops;

  @override
  DetailsState get initialState => InitialState();

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is GetMovieDetails) {
      yield* _mapGetDetailsResToState(event.detailedMovie);
    }
  }

  Stream<DetailsState> _mapGetDetailsResToState(Movie detailedMovie) async* {
    Result<Movie> detailedMovieRes = await _getBackDrops(
      detailedMovie,
    );

    if (detailedMovieRes is Success) {
      yield LoadedMovieDetails(detailedMovieRes.data);
    } else {
      yield DetailsError(detailedMovieRes.error.message);
    }
  }
}
