import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/view_models/search_model.dart';
import 'package:tmdb_client_kobe/src/home/widgets/movie_card.dart';
import 'package:tmdb_client_kobe/src/util/base_view.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class SearchView extends StatelessWidget {
  Widget build(context) {
    double height = MediaQuery.of(context).size.height;
    return BaseView<SearchModel>(
      onModelReady: (model) => model.initModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Search a movie",
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
          body: SingleChildScrollView(
            controller: model.viewScroller,
            child: Column(
              children: [
                Container(
                  height: height,
                  margin: EdgeInsets.only(
                    top: 0.03 * height,
                  ),
                  child: FloatingSearchBar(
                    decoration: InputDecoration(
                      hintText: model.searchValue ?? 'Search',
                      hasFloatingPlaceholder: false,
                    ),
                    children: model.state == ViewState.Busy
                        ? [
                            Container(
                              height: 0.8 * height,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ]
                        : model.searchResult.isNotEmpty
                            ? [
                                Column(
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 0.04 * height),
                                      height: 0.08 * height,
                                      child: Text(
                                        'Results: (page ${model.page}/${model.totalPages})',
                                        style: TextStyle(
                                          color: Color(0xFFAAAAAA),
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: model.leftList.map(
                                            (movie) {
                                              return Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    model.setDetails(
                                                        moviee: movie);
                                                    Navigator.of(context)
                                                        .pushNamed('/details');
                                                  },
                                                  child: MovieCard(
                                                    title: movie.title,
                                                    releaseDate:
                                                        movie.releaseDate,
                                                    posterUrl: movie.posterPath,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: model.rightList.map(
                                            (movie) {
                                              return Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    model.setDetails(
                                                        moviee: movie);
                                                    Navigator.of(context)
                                                        .pushNamed('/details');
                                                  },
                                                  child: MovieCard(
                                                    title: movie.title,
                                                    releaseDate:
                                                        movie.releaseDate,
                                                    posterUrl: movie.posterPath,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ],
                                    ),
                                    ShowMoreResults(
                                      height: height,
                                      onShowMorePressed:
                                          model.onPressShowMoreResults,
                                    )
                                  ],
                                )
                              ]
                            : model.error
                                ? [
                                    Container(
                                      height: 0.8 * height,
                                      child: Center(
                                        child: Text('error'),
                                      ),
                                    ),
                                  ]
                                : model.initial
                                    ? [
                                        Container(
                                          height: 0.8 * height,
                                        )
                                      ]
                                    : [
                                        Container(
                                          height: 0.8 * height,
                                          child: Center(
                                            child: Text('Nothing Found :('),
                                          ),
                                        )
                                      ],
                    trailing: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        model.onSearchPressed();
                      },
                    ),
                    onChanged: model.onChangeSearchValue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ShowMoreResults extends StatelessWidget {
  final Function onShowMorePressed;
  final double height;

  ShowMoreResults({
    this.height,
    this.onShowMorePressed,
  });

  Widget build(context) {
    return InkWell(
      onTap: onShowMorePressed,
      child: Container(
        color: Color.fromARGB(100, 0, 0, 0),
        height: 0.1 * height,
        margin: EdgeInsets.only(bottom: 0.15 * height),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Show more Results: '),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
