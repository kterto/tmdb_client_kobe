import 'package:flutter/material.dart';

import 'package:tmdb_client_kobe/src/home/view_models/home_model.dart';
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
            onPressed: () => Navigator.of(context).pushNamed('/search'),
            child: Icon(Icons.search),
          ),
          body: model.state == ViewState.Busy
              ? model.upcomingList.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : MoviesCardGrid(
                      leftList: model.leftList,
                      rightList: model.rightList,
                      setDetails: model.setDetails,
                      isHome: true,
                      viewScroller: model.viewScroller,
                      state: model.state,
                    )
              : model.error
                  ? Center(
                      child: Text('error'),
                    )
                  : MoviesCardGrid(
                      leftList: model.leftList,
                      rightList: model.rightList,
                      setDetails: model.setDetails,
                      isHome: true,
                      viewScroller: model.viewScroller,
                      state: model.state,
                    ),
        );
      },
    );
  }
}
