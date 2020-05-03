import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tmdb_client_kobe/src/home/blocs/home/home_state.dart';
import 'package:tmdb_client_kobe/src/home/blocs/search/search_bloc.dart';
import 'package:tmdb_client_kobe/src/home/widgets/correct_search_field.dart';
import 'package:tmdb_client_kobe/src/home/widgets/movies_card_grid.dart';
import 'package:tmdb_client_kobe/src/locator.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBloc _bloc = locator<SearchBloc>();

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
      body: BlocProvider<SearchBloc>.value(
        value: _bloc,
        child: SingleChildScrollView(
          controller: viewScroller,
          physics: AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                children: <Widget>[
                  CorrectSearchField(
                    fontSize: 14,
                    borderRadius: 6,
                    hint: 'Search a movie',
                    keyboradType: TextInputType.text,
                  ),
                  Builder(
                    builder: (context) {
                      switch (state.runtimeType) {
                        case InitialState:
                          return Container();
                          break;
                        case LoadingSearch:
                          return Container(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                          break;
                        case LoadedSearch:
                          return Column(
                            children: <Widget>[
                              DisplayResults(
                                height: Get.height,
                                page: (state as LoadedSearch).page,
                                totalPages: _bloc.totalPages,
                                onShowMorePressed: () =>
                                    _bloc.add(SearchNextPage()),
                              ),
                              MoviesCardGrid(
                                moviesList:
                                    (state as LoadedSearch).searchResults,
                                isBloc: true,
                                isHome: false,
                                onShowMorePressed: () =>
                                    _bloc.add(SearchNextPage()),
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                page: (state as LoadedSearch).page,
                                totalPages: _bloc.totalPages,
                                viewScroller: viewScroller,
                              ),
                            ],
                          );
                          break;
                        case MovieNotFound:
                          return Center(
                            child: Text((state as MovieNotFound).message),
                          );
                        case EndOfList:
                          return Column(
                            children: <Widget>[
                              DisplayResults(
                                height: Get.height,
                                page: _bloc.currentPage,
                                totalPages: _bloc.totalPages,
                                onShowMorePressed: null,
                              ),
                              MoviesCardGrid(
                                moviesList: (state as EndOfList).searchResults,
                                isBloc: true,
                                isHome: false,
                                onShowMorePressed: () =>
                                    print('show more in the grid'),
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                page: (state as EndOfList).page,
                                totalPages: _bloc.totalPages,
                                viewScroller: viewScroller,
                              ),
                            ],
                          );
                          break;
                        default:
                          return Container();
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
    _bloc.close();
  }
}
