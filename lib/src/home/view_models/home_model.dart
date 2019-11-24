import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_upcoming_service.dart';
import 'package:tmdb_client_kobe/src/locator.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class HomeModel extends BaseViewModel {
  FetchUpcomingService _fetchUpcomingService;
  DetailsService _detailsService;
  List<Movie> upcomingList;
  List<Movie> leftList;
  List<Movie> rightList;
  bool error;

  void initModel() async {
    _fetchUpcomingService = locator<FetchUpcomingService>();
    _detailsService = locator<DetailsService>();

    error = false;
    leftList = [];
    rightList = [];

    setState(ViewState.Busy);

    if (await _fetchUpcomingService.getUpcom()) {
      upcomingList = _fetchUpcomingService.upcomingList;

      for (int j = 0; j < upcomingList.length; j++) {
        if (j % 2 == 0) {
          leftList.add(upcomingList[j]);
        } else {
          rightList.add(upcomingList[j]);
        }
      }

      setState(ViewState.Idle);
    } else {
      error = true;
      setState(ViewState.Idle);
    }
  }

  void setDetails({Movie moviee}) {
    _detailsService.setDetailedMovie(mov: moviee);
  }
}
