import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:tmdb_client_kobe/src/home/stores/seach_store.dart';
import 'package:tmdb_client_kobe/src/home/widgets/correct_search_field.dart';
import 'package:tmdb_client_kobe/src/home/widgets/movies_card_grid.dart';
import 'package:tmdb_client_kobe/src/locator.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchStore _store = locator<SearchStore>();
  final ScrollController viewScroller = ScrollController();

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: <Widget>[
            CorrectSearchField(
              fontSize: 14,
              borderRadius: 6,
              hint: 'Search a movie',
              keyboradType: TextInputType.text,
              onSearchCallback: (String movieName) =>
                  _store.searchMovie(movieName),
            ),
            Observer(
              builder: (_) {
                if (_store.searching) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (_store.searchedList == null) {
                    if (_store.searchedListError == null) {
                      return Container();
                    } else {
                      return Center(
                        child: Text(_store.searchedListError),
                      );
                    }
                  } else {
                    if (_store.notFound != null) {
                      return Center(
                        child: Text(_store.notFound),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          DisplayResults(
                            height: Get.height,
                            page: _store.currentPage,
                            totalPages: _store.totalPages,
                            onShowMorePressed: _store.searchNextPage,
                          ),
                          MoviesCardGrid(
                            moviesList: _store.searchedList,
                            isMobX: true,
                            isHome: false,
                            onShowMorePressed: _store.searchNextPage,
                            height: MediaQuery.of(context).size.height * 0.7,
                            page: _store.currentPage,
                            totalPages: _store.totalPages,
                            viewScroller: viewScroller,
                          ),
                        ],
                      );
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
