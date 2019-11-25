import 'package:flutter/material.dart';

import 'package:tmdb_client_kobe/src/home/view_models/home_model.dart';
import 'package:tmdb_client_kobe/src/home/widgets/movie_card.dart';
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
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : model.error
                  ? Center(
                      child: Text('error'),
                    )
                  : SingleChildScrollView(
                      controller: model.viewScroller,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: model.leftList.map(
                              (movie) {
                                return Center(
                                  child: InkWell(
                                    onTap: () {
                                      model.setDetails(moviee: movie);
                                      Navigator.of(context)
                                          .pushNamed('/details');
                                    },
                                    child: MovieCard(
                                      title: movie.title,
                                      releaseDate: movie.releaseDate,
                                      posterUrl: movie.posterPath,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: model.rightList.map(
                              (movie) {
                                return Center(
                                  child: InkWell(
                                    onTap: () {
                                      model.setDetails(moviee: movie);
                                      Navigator.of(context)
                                          .pushNamed('/details');
                                    },
                                    child: MovieCard(
                                      title: movie.title,
                                      releaseDate: movie.releaseDate,
                                      posterUrl: movie.posterPath,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
