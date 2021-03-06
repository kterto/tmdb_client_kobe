import 'package:get_it/get_it.dart';
import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_genres_service.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_upcoming_service.dart';
import 'package:tmdb_client_kobe/src/home/services/search_service.dart';
import 'package:tmdb_client_kobe/src/home/view_models/details_model.dart';
import 'package:tmdb_client_kobe/src/home/view_models/home_model.dart';
import 'package:tmdb_client_kobe/src/home/view_models/search_model.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => FetchUpcomingService());
  locator.registerLazySingleton(() => DetailsService());
  locator.registerLazySingleton(() => FetchGenresService());
  locator.registerLazySingleton(() => SearchService());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => DetailsModel());
  locator.registerFactory(() => SearchModel());
}
