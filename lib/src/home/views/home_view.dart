import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tmdb_client_kobe/src/home/view_models/home_model.dart';
import 'package:tmdb_client_kobe/src/home/views/search_view.dart';
import 'package:tmdb_client_kobe/src/home/widgets/movies_card_grid.dart';
import 'package:tmdb_client_kobe/src/util/base_view.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class HomeView extends StatelessWidget {
  Widget build(context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.initModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Upcoming",
              style: TextStyle(
                color: Color(0xFFAAAAAA),
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.to(SearchView()),
            child: Icon(Icons.search),
          ),
          body: Builder(
            builder: (context) {
              if (model.state == ViewState.Busy) {
                if (model.upcomingList.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return MoviesCardGrid(
                    moviesList: model.upcomingList,
                    setDetails: model.setDetails,
                    isHome: true,
                    viewScroller: model.viewScroller,
                    state: model.state,
                    height: MediaQuery.of(context).size.height,
                  );
                }
              } else {
                if (model.upcomingList.isEmpty) {
                  return Center(
                    child: Text('error'),
                  );
                } else {
                  return MoviesCardGrid(
                    moviesList: model.upcomingList,
                    setDetails: model.setDetails,
                    isHome: true,
                    viewScroller: model.viewScroller,
                    state: model.state,
                    height: MediaQuery.of(context).size.height,
                  );
                }
              }
            },
          ),
        );
      },
    );
  }
}
