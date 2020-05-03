import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'package:tmdb_client_kobe/src/home/services/fetch_genres_service.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_upcoming_service.dart';
import 'package:tmdb_client_kobe/src/home/views/details_view.dart';
import 'package:tmdb_client_kobe/src/locator.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class HomeModel extends BaseViewModel {
  final FetchUpcomingService _fetchUpcoming;
  final FetchGenresService _fetchGenres;
  ScrollController viewScroller;
  BehaviorSubject _increasedPage$;
  List<Movie> upcomingList;
  bool error;

  HomeModel({
    @required FetchUpcomingService fetchUpcoming,
    @required FetchGenresService fetchGenres,
  })  : _fetchUpcoming = fetchUpcoming,
        _fetchGenres = fetchGenres;

  void initModel() async {
    setState(ViewState.Busy);
    _increasedPage$ = locator<FetchUpcomingService>().increasedPage$;
    viewScroller = ScrollController();

    error = false;
    upcomingList = [];

    if (await _fetchGenres.fetchGenres()) {
      print('ok');
    }

    if (await _fetchUpcoming.getUpcom()) {
      upcomingList = _fetchUpcoming.upcomingList;

      setState(ViewState.Idle);
    } else {
      error = true;
      setState(ViewState.Idle);
    }

    viewScroller.addListener(() async {
      if (viewScroller.position.pixels ==
          viewScroller.position.maxScrollExtent) {
        setState(ViewState.Busy);

        if (await _fetchUpcoming.getUpcom()) {
          upcomingList = _fetchUpcoming.upcomingList;

          setState(ViewState.Idle);
        } else {
          error = true;
          setState(ViewState.Idle);
        }
      }
    });

    _increasedPage$.listen((increased) async {
      if (increased) {
        viewScroller.position
            .correctBy(viewScroller.position.maxScrollExtent / 2 - 1);
      }
    });
  }

  void setDetails({Movie moviee}) {
    Get.to(DetailsView(moviee));
  }
}
