import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

import 'movie_card.dart';

class MoviesCardGrid extends StatelessWidget {
  final List<Movie> leftList;
  final List<Movie> rightList;
  final Function setDetails;

  MoviesCardGrid({
    this.leftList,
    this.rightList,
    this.setDetails,
  });

  Widget build(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: leftList.map(
            (movie) {
              return Center(
                child: InkWell(
                  onTap: () {
                    setDetails(moviee: movie);
                    Navigator.of(context).pushNamed('/details');
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
          children: rightList.map(
            (movie) {
              return Center(
                child: InkWell(
                  onTap: () {
                    setDetails(moviee: movie);
                    Navigator.of(context).pushNamed('/details');
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
    );
  }
}
