import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_client_kobe/src/home/blocs/home/home_event.dart';
import 'package:tmdb_client_kobe/src/home/blocs/home/home_state.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_genres_service.dart';
import 'package:tmdb_client_kobe/src/home/services/get_upcoming_list_service.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUpcompingListService _getUpcompingList;

  final FetchGenresService _fetchGenres;
  int nextPage = 1;
  List<Movie> upcomingList = [];

  HomeBloc({
    @required FetchGenresService fetchGenres,
    @required GetUpcompingListService getUpcomingList,
  })  : _fetchGenres = fetchGenres,
        _getUpcompingList = getUpcomingList;

  @override
  HomeState get initialState => InitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchNextPage) {
      yield* _fetchUpcomingResToState();
    }
  }

  Stream<HomeState> _fetchUpcomingResToState() async* {
    Result<List<Movie>> upcomingListRes = await _getUpcompingList(
      page: nextPage,
    );

    if (upcomingListRes is Success) {
      nextPage++;

      upcomingList = [
        ...upcomingList,
        ...upcomingListRes.data,
      ];

      yield LoadedUpcoming(upcomingList);
    } else {
      yield FetchUpcomingError(upcomingListRes.error.message);
    }
  }
}
