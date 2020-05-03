import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/view_models/search_model.dart';
import 'package:tmdb_client_kobe/src/home/widgets/movies_card_grid.dart';
import 'package:tmdb_client_kobe/src/home/widgets/search_field.dart';
import 'package:tmdb_client_kobe/src/util/base_view.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class SearchView extends StatelessWidget {
  final ScrollController viewScroller = ScrollController();

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
            controller: viewScroller,
            child: Column(
              children: <Widget>[
                SearchField(
                  fontSize: 14,
                  borderRadius: 6,
                  hint: 'Search a movie',
                  // inputWidth: 0.9 * width,
                  keyboradType: TextInputType.text,
                  onChanged: model.onChangeSearchValue,
                  formControl: model.searchField,
                  onSearchPressed: model.onSearchPressed,
                ),
                Builder(
                  builder: (context) {
                    if (model.state == ViewState.Busy) {
                      return Container(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      if (model.searchResult.isNotEmpty) {
                        return Column(
                          children: <Widget>[
                            DisplayResults(
                              height: height,
                              page: model.page,
                              totalPages: model.totalPages,
                              onShowMorePressed: model.onPressShowMoreResults,
                            ),
                            MoviesCardGrid(
                              leftList: model.leftList,
                              rightList: model.rightList,
                              moviesList: model.searchResult,
                              setDetails: model.setDetails,
                              isHome: false,
                              onShowMorePressed: model.page <= model.totalPages
                                  ? model.onPressShowMoreResults
                                  : null,
                              height: MediaQuery.of(context).size.height * 0.7,
                              page: model.page,
                              totalPages: model.totalPages,
                              viewScroller: viewScroller,
                            ),
                          ],
                        );
                      } else {
                        if (model.initial) {
                          return Container();
                        } else {
                          return Center(
                            child: Text('Not found!'),
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
      },
    );
  }
}
