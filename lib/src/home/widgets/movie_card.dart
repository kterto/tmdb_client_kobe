import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/widgets/release_date.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String posterUrl;
  final DateTime releaseDate;

  MovieCard({
    this.title,
    this.posterUrl,
    this.releaseDate,
  });

  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double cardHeight = height * 0.4;
    double cardWidth = width * 0.5;

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          width: cardWidth,
          height: cardHeight,
          color: Color(0xFFFFFFFF),
          child: (posterUrl != null)
              ? Image.network(
                  posterUrl,
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.broken_image,
                  size: cardWidth,
                ),
        ),
        Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(0, 0, 0, 0),
                Color.fromARGB(150, 0, 0, 0),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: cardHeight * 0.10,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: cardWidth,
                child: AutoSizeText(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                ),
              ),
              releaseDate != null
                  ? ReleaseDate(
                      day: releaseDate.day,
                      month: releaseDate.month,
                      year: releaseDate.year,
                    )
                  : Text('Unkown'),
            ],
          ),
        ),
      ],
    );
  }
}
