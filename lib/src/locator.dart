import 'package:get_it/get_it.dart';
import 'package:tmdb_client_kobe/src/home/blocs/details/details_bloc_barrel.dart';
import 'package:tmdb_client_kobe/src/home/blocs/home/home_bloc_barrel.dart';
import 'package:tmdb_client_kobe/src/home/blocs/search/search_bloc.dart';

import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_genres_service.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_upcoming_service.dart';
import 'package:tmdb_client_kobe/src/home/services/get_upcoming_list_service.dart';
import 'package:tmdb_client_kobe/src/home/services/search_movie_sercice.dart';
import 'package:tmdb_client_kobe/src/home/services/search_service.dart';
import 'package:tmdb_client_kobe/src/home/stores/details_store.dart';
import 'package:tmdb_client_kobe/src/home/stores/home_store.dart';
import 'package:tmdb_client_kobe/src/home/stores/seach_store.dart';
import 'package:tmdb_client_kobe/src/home/view_models/details_model.dart';
import 'package:tmdb_client_kobe/src/home/view_models/home_model.dart';
import 'package:tmdb_client_kobe/src/home/view_models/search_model.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => FetchUpcomingService());
  locator.registerLazySingleton(() => GetBackDropsService());
  locator.registerLazySingleton(() => FetchGenresService());
  locator.registerLazySingleton(() => SearchService());
  locator.registerLazySingleton(() => SearchMovieService());
  locator.registerLazySingleton(() => GetUpcompingListService());

  locator.registerFactory(
    () => HomeBloc(
      fetchGenres: locator(),
      getUpcomingList: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailsBloc(
      getBackDrops: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBloc(
      searchMovie: locator(),
    ),
  );

  locator.registerFactory(
    () => HomeStore(
      getUpcompingList: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailsStore(
      getBackDrops: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchStore(
      searchMovie: locator(),
    ),
  );

  locator.registerFactory(
    () => HomeModel(
      fetchGenres: locator(),
      fetchUpcoming: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailsModel(
      getBackDrops: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchModel(
      getBackDrops: locator(),
      searchService: locator(),
    ),
  );
}
