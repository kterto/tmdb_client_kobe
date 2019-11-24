import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/locator.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class DetailsModel extends BaseViewModel {
  DetailsService _detailsService;
  Movie movie;

  void initModel() {
    _detailsService = locator<DetailsService>();
    movie = _detailsService.detailedMovie;
  }
}
