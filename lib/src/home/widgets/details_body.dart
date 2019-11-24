import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DetailsBody extends StatelessWidget {
  final String posterUrl;
  final List<String> backdropUrls;
  final String overview;

  DetailsBody({
    this.posterUrl,
    this.backdropUrls,
    this.overview,
  });

  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
