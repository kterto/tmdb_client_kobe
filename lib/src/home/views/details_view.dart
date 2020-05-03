import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/view_models/details_model.dart';
import 'package:tmdb_client_kobe/src/home/widgets/details_body.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';
import 'package:tmdb_client_kobe/src/util/base_view.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class DetailsView extends StatelessWidget {
  final Movie detailedMovie;

  DetailsView(this.detailedMovie);

  Widget build(context) {
    return BaseView<DetailsModel>(
      onModelReady: (model) => model.initModel(
        detailedMovie: detailedMovie,
      ),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              detailedMovie.title,
              style: TextStyle(
                color: Color(0xFFAAAAAA),
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w400,
              ),
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
          ),
          body: model.state == ViewState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : model.detailedMovieRes is Failure
                  ? Center(
                      child: Text('Error'),
                    )
                  : DetailsBody(
                      overview: model.detailedMovieRes.data.overView,
                      posterUrl: model.detailedMovieRes.data.posterPath,
                      backdropUrls: model.detailedMovieRes.data.backdropPath,
                      genres: model.detailedMovieRes.data.genre,
                      releaseDate: model.detailedMovieRes.data.releaseDate,
                    ),
        );
      },
    );
  }
}
