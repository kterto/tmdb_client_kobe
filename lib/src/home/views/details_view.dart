import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/view_models/details_model.dart';
import 'package:tmdb_client_kobe/src/home/widgets/details_body.dart';
import 'package:tmdb_client_kobe/src/util/base_view.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class DetailsView extends StatelessWidget {
  Widget build(context) {
    return BaseView<DetailsModel>(
      onModelReady: (model) => model.initModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.movie.title,
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
              : model.error
                  ? Center(
                      child: Text('Error'),
                    )
                  : DetailsBody(
                      overview: model.movie.overView,
                      posterUrl: model.movie.posterPath,
                      backdropUrls: model.movie.backdropPath,
                      genres: model.movie.genre,
                      releaseDate: model.movie.releaseDate,
                    ),
        );
      },
    );
  }
}
