import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb_client_kobe/src/home/stores/details_store.dart';
import 'package:tmdb_client_kobe/src/home/widgets/details_body.dart';
import 'package:tmdb_client_kobe/src/locator.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

class DetailsPage extends StatefulWidget {
  final Movie detailedMovie;

  const DetailsPage({
    Key key,
    @required this.detailedMovie,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsStore _store = locator<DetailsStore>();

  @override
  void initState() {
    _store.setDetailedMovie(widget.detailedMovie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.detailedMovie.title,
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
      body: Observer(
        builder: (_) {
          if (_store.detailedMovie.backdropPath == null) {
            _store.getBackdrops();
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (_store.getBackdropsErrorMsg == null) {
              return DetailsBody(
                overview: _store.detailedMovie.overView,
                posterUrl: _store.detailedMovie.posterPath,
                backdropUrls: _store.detailedMovie.backdropPath,
                genres: _store.detailedMovie.genre,
                releaseDate: _store.detailedMovie.releaseDate,
              );
            } else {
              return Center(
                child: Text(_store.getBackdropsErrorMsg),
              );
            }
          }
        },
      ),
    );
  }
}
