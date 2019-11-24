import 'package:get_it/get_it.dart';
import 'package:tmdb_client_kobe/src/home/fetch_upcoming_service.dart';
import 'package:tmdb_client_kobe/src/home/home_model.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => FetchUpcomingService());

  locator.registerFactory(() => HomeModel());
}
