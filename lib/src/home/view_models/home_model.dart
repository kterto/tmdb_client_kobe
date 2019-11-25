import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_genres_service.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_upcoming_service.dart';
import 'package:tmdb_client_kobe/src/locator.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class HomeModel extends BaseViewModel {
  FetchUpcomingService _fetchUpcomingService;
  DetailsService _detailsService;
  FetchGenresService _fetchGenresService;
  ScrollController viewScroller;
  BehaviorSubject _increasedPage$;
  List<Movie> upcomingList;
  List<Movie> leftList;
  List<Movie> rightList;
  bool error;

  void initModel() async {
    _fetchUpcomingService = locator<FetchUpcomingService>();
    _detailsService = locator<DetailsService>();
    _fetchGenresService = locator<FetchGenresService>();
    _increasedPage$ = locator<FetchUpcomingService>().increasedPage$;
    viewScroller = ScrollController();
    error = false;

    setState(ViewState.Busy);
    if (await _fetchGenresService.fetchGenres()) {
      print('ok');
    }

    if (await _fetchUpcomingService.getUpcom()) {
      upcomingList = _fetchUpcomingService.upcomingList;

      sliceList();

      setState(ViewState.Idle);
    } else {
      error = true;
      setState(ViewState.Idle);
    }

    viewScroller.addListener(() async {
      // print(viewScroller.position);
      if (viewScroller.position.pixels ==
          viewScroller.position.maxScrollExtent) {
        setState(ViewState.Busy);

        if (await _fetchUpcomingService.getUpcom()) {
          upcomingList = _fetchUpcomingService.upcomingList;

          sliceList();

          setState(ViewState.Idle);
        } else {
          error = true;
          setState(ViewState.Idle);
        }
      }
    });

    _increasedPage$.listen((increased) async {
      if (increased) {
        await Future.delayed(Duration(milliseconds: 500));
        viewScroller.animateTo(
          viewScroller.position.maxScrollExtent / 2 - 1,
          duration: Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void setDetails({Movie moviee}) {
    _detailsService.setDetailedMovie(mov: moviee);
  }

  void sliceList() {
    leftList = [];
    rightList = [];

    for (int j = 0; j < upcomingList.length; j++) {
      if (j % 2 == 0) {
        leftList.add(upcomingList[j]);
      } else {
        rightList.add(upcomingList[j]);
      }
    }
  }
}
