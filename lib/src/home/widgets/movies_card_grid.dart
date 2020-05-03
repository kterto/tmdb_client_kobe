import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_client_kobe/src/home/pages/details_page.dart';
import 'package:tmdb_client_kobe/src/home/screens/details_screen.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

import 'movie_card.dart';

class MoviesCardGrid extends StatelessWidget {
  final List<Movie> leftList;
  final List<Movie> rightList;
  final List<Movie> moviesList;
  final Function setDetails;
  final ViewState state;
  final bool isHome;
  final Function onShowMorePressed;
  final double height;
  final ScrollController viewScroller;
  final int page;
  final int totalPages;
  final bool isBloc;
  final bool isMobX;
  final bool neverScroll;

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
    this.moviesList,
    this.isBloc = false,
    this.isMobX = false,
    this.neverScroll = false,
  });

  Widget build(context) {
    double cardHeight = height * 0.4;

    return Container(
      height: height,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:
              MediaQuery.of(context).size.width * 0.5 / cardHeight,
        ),
        itemCount: moviesList.length,
        controller: viewScroller,
        physics: neverScroll
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (isBloc) {
                Get.to(DetailsScreen(moviesList[index]));
              } else if (isMobX) {
                Get.to(DetailsPage(detailedMovie: moviesList[index]));
              } else {
                setDetails(moviee: moviesList[index]);
              }
            },
            child: MovieCard(
              title: moviesList[index].title,
              releaseDate: moviesList[index].releaseDate,
              posterUrl: moviesList[index].posterPath,
            ),
          );
        },
      ),
    );
  }
}

class DisplayResults extends StatelessWidget {
  final double height;
  final int page;
  final int totalPages;
  final Function onShowMorePressed;

  DisplayResults({
    this.height,
    this.page,
    this.totalPages,
    this.onShowMorePressed,
  });

  Widget build(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
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
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: onShowMorePressed,
        )
      ],
    );
  }
}
