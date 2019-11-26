import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/widgets/show_more_results.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

import 'movie_card.dart';

class MoviesCardGrid extends StatelessWidget {
  final List<Movie> leftList;
  final List<Movie> rightList;
  final Function setDetails;
  final ViewState state;
  final bool isHome;
  final Function onShowMorePressed;
  final double height;
  final ScrollController viewScroller;
  final int page;
  final int totalPages;

  MoviesCardGrid({
    this.leftList,
    this.rightList,
    this.setDetails,
    this.state,
    this.isHome,
    this.onShowMorePressed,
    this.height,
    this.viewScroller,
    this.page,
    this.totalPages,
  });

  Widget build(context) {
    double height = MediaQuery.of(context).size.height;
    double cardHeight = height * 0.4;

    return ListView.builder(
      shrinkWrap: true,
      itemExtent: cardHeight,
      cacheExtent: 10,
      controller: viewScroller,
      itemCount: isHome ? leftList.length + 1 : leftList.length + 1,
      itemBuilder: (context, ind) {
        int index;
        if (isHome) {
          index = ind;
        } else {
          if (ind == 0) {
            return DisplayResults(
              height: height,
              page: page,
              totalPages: totalPages,
            );
          } else {
            index = ind - 1;
          }
        }
        if (index < leftList.length) {
          Movie movieLeft = leftList[index];
          Movie movieRight;
          bool doNotShow = false;

          if (index < rightList.length) {
            movieRight = rightList[index];
          } else {
            doNotShow = true;
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: InkWell(
                  onTap: () {
                    setDetails(moviee: leftList[index]);
                    Navigator.of(context).pushNamed('/details');
                  },
                  child: MovieCard(
                    title: movieLeft.title,
                    releaseDate: movieLeft.releaseDate,
                    posterUrl: movieLeft.posterPath,
                  ),
                ),
              ),
              doNotShow
                  ? Offstage(
                      child: Container(),
                    )
                  : Center(
                      child: InkWell(
                        onTap: () {
                          setDetails(moviee: movieRight);
                          Navigator.of(context).pushNamed('/details');
                        },
                        child: MovieCard(
                          title: movieRight.title,
                          releaseDate: movieRight.releaseDate,
                          posterUrl: movieRight.posterPath,
                        ),
                      ),
                    ),
            ],
          );
        } else {
          return isHome
              ? state == ViewState.Busy
                  ? Container(
                      height: 100,
                      color: Color.fromARGB(100, 0, 0, 0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      height: 100,
                      color: Color.fromARGB(100, 0, 0, 0),
                    )
              : ShowMoreResults(
                  height: height,
                  onShowMorePressed: onShowMorePressed,
                );
        }
      },
    );
  }
}

class DisplayResults extends StatelessWidget {
  final double height;
  final int page;
  final int totalPages;

  DisplayResults({
    this.height,
    this.page,
    this.totalPages,
  });

  Widget build(context) {
    return Container(
      margin: EdgeInsets.only(top: 0.04 * height),
      height: 0.08 * height,
      child: Text(
        'Results: (pages $page/$totalPages)',
        style: TextStyle(
          color: Color(0xFFAAAAAA),
          fontFamily: "OpenSans",
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
    );
  }
}
