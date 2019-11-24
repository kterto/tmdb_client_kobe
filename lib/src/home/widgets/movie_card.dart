import 'package:auto_size_text/auto_size_text.dart';
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
          bottom: cardHeight * 0.10,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: cardWidth,
                child: AutoSizeText(
                  title,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                ),
              ),
              ReleaseDate(
                day: releaseDate.day,
                month: releaseDate.month,
                year: releaseDate.year,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReleaseDate extends StatelessWidget {
  final int day;
  final int month;
  final int year;

  ReleaseDate({
    this.day,
    this.month,
    this.year,
  });

  String numberToString(int number) {
    if (number < 10) {
      return '0$number';
    } else {
      return number.toString();
    }
  }

  Widget build(context) {
    return Text(
      "Release Date: ${numberToString(day)}/${numberToString(month)}/$year",
      style: TextStyle(
        fontFamily: "OpenSans",
        fontSize: 12,
        color: Colors.white,
      ),
    );
  }
}
