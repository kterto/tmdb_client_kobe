import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/widgets/release_date.dart';

class DetailsBody extends StatelessWidget {
  final String posterUrl;
  final List<String> backdropUrls;
  final List<String> genres;
  final String overview;
  final DateTime releaseDate;

  DetailsBody({
    this.posterUrl,
    this.backdropUrls,
    this.overview,
    this.genres,
    this.releaseDate,
  });

  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String gens = '';

    genres.forEach((gen) {
      gens = gens + gen + ',';
    });

    gens = gens.substring(0, gens.length - 1);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0.03 * height, left: 0.03 * width),
              height: 0.2 * height,
              width: 0.25 * width,
              child: Image.network(
                posterUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 0.02 * width,
                top: height * 0.03,
              ),
              width: 0.6 * width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Overview:',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                      color: Color(0xFF333333),
                    ),
                  ),
                  AutoSizeText(
                    overview,
                    maxLines: 10,
                    minFontSize: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 0.03 * height, left: 0.03 * width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                'Genre: ' + gens,
                maxLines: 2,
                minFontSize: 10,
                softWrap: true,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12,
                ),
              ),
              ReleaseDate(
                day: releaseDate.day,
                month: releaseDate.month,
                year: releaseDate.year,
                textColor: Color(0xFF333333),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 0.05 * height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 0.03 * width),
                child: Text(
                  'Backdrops:',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: backdropUrls.map((url) {
                    return Container(
                      height: 0.3 * height,
                      width: 0.8 * width,
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
