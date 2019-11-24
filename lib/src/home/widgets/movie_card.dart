import 'package:flutter/material.dart';

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
          child: Image.network(
            posterUrl,
            fit: BoxFit.cover,
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
          bottom: cardHeight * 0.15,
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text(
                "Release Date: ${releaseDate.day}/${releaseDate.month}/${releaseDate.year}",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 12,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
