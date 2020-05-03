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

    if (gens.isNotEmpty) {
      gens = gens.substring(0, gens.length - 1);
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 0.03 * height, left: 0.03 * width),
                height: 0.2 * height,
                width: 0.25 * width,
                child: (posterUrl != null)
                    ? Image.network(
                        posterUrl,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.broken_image,
                        size: 0.25 * width,
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
                      maxLines: 20,
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
                  gens.isNotEmpty ? 'Genre: ' + gens : 'Genre: unknown',
                  maxLines: 2,
                  minFontSize: 10,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12,
                  ),
                ),
                releaseDate != null
                    ? ReleaseDate(
                        day: releaseDate.day,
                        month: releaseDate.month,
                        year: releaseDate.year,
                        textColor: Color(0xFF333333),
                      )
                    : Text('Unkown'),
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
                    child: Container(
                      height: 0.3 * height,
                      width: width,
                      child: ListView.builder(
                        itemCount: backdropUrls.length ?? 1,
                        shrinkWrap: true,
                        //   itemExtent: 0.3 * height,
                        scrollDirection: Axis.horizontal,
                        cacheExtent: 0.8 * width,
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            height: 0.3 * height,
                            width: 0.8 * width,
                            child: backdropUrls[index] != null
                                ? Image.network(
                                    backdropUrls[index],
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.broken_image,
                                    size: 0.8 * width,
                                  ),
                          );
                        },
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackdropsView extends StatelessWidget {
  final List<String> backdropsList;
  final double height;
  final double width;

  BackdropsView({
    this.backdropsList,
    this.height,
    this.width,
  });

  Widget build(context) {
    return backdropsList.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            // shrinkWrap: true,
            // itemExtent: width * 0.8,
            itemCount: backdropsList?.length ?? 0,
            itemBuilder: (context, index) {
              String url = backdropsList[index];
              return url != null
                  ? Container(
                      height: 0.3 * height,
                      width: 0.8 * width,
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 0.3 * height,
                      width: 0.8 * width,
                      child: Icon(
                        Icons.broken_image,
                        size: 0.8 * width,
                      ),
                    );
            },
          )
        : Container(
            height: 0.3 * height,
            width: 0.8 * width,
            child: Icon(Icons.broken_image),
          );
  }
}
