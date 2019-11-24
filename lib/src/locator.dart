import 'package:get_it/get_it.dart';
import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_upcoming_service.dart';
import 'package:tmdb_client_kobe/src/home/view_models/details_model.dart';
import 'package:tmdb_client_kobe/src/home/view_models/home_model.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => FetchUpcomingService());
  locator.registerLazySingleton(() => DetailsService());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => DetailsModel());
}
