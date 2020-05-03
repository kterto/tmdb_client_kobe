import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_client_kobe/src/home/blocs/details/details_bloc_barrel.dart';
import 'package:tmdb_client_kobe/src/home/widgets/details_body.dart';
import 'package:tmdb_client_kobe/src/locator.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

class DetailsScreen extends StatelessWidget {
  final Movie detailedMovie;
  final DetailsBloc bloc = locator<DetailsBloc>();

  DetailsScreen(this.detailedMovie);

  Widget build(context) {
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
      body: BlocProvider<DetailsBloc>.value(
        value: bloc,
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            return Builder(
              builder: (context) {
                switch (state.runtimeType) {
                  case InitialState:
                    bloc.add(GetMovieDetails(detailedMovie));
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case LoadedMovieDetails:
                    return DetailsBody(
                      overview:
                          (state as LoadedMovieDetails).detailedMovie.overView,
                      posterUrl: (state as LoadedMovieDetails)
                          .detailedMovie
                          .posterPath,
                      backdropUrls: (state as LoadedMovieDetails)
                          .detailedMovie
                          .backdropPath,
                      genres: (state as LoadedMovieDetails).detailedMovie.genre,
                      releaseDate: (state as LoadedMovieDetails)
                          .detailedMovie
                          .releaseDate,
                    );
                    break;
                  case DetailsError:
                    return Center(
                      child: Text((state as DetailsError).message),
                    );
                    break;
                  default:
                    return Container();
                    break;
                }
              },
            );
          },
        ),
      ),
    );
  }

  dispose() {
    bloc.close();
  }
}
