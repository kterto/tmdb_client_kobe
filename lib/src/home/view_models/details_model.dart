import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/locator.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class DetailsModel extends BaseViewModel {
  DetailsService _detailsService;
  Movie movie;
  bool error;

  void initModel() async {
    _detailsService = locator<DetailsService>();
    movie = _detailsService.detailedMovie;
    error = false;
    setState(ViewState.Busy);

    if (await _detailsService.getBackDrops()) {
      movie = _detailsService.detailedMovie;
      print(movie.overView);
      print(movie.backdropPath);

      setState(ViewState.Idle);
    } else {
      error = true;
      setState(ViewState.Idle);
    }
  }
}
