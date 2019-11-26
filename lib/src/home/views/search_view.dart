import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/view_models/search_model.dart';
import 'package:tmdb_client_kobe/src/home/widgets/movies_card_grid.dart';
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
                                MoviesCardGrid(
                                  leftList: model.leftList,
                                  rightList: model.rightList,
                                  setDetails: model.setDetails,
                                  isHome: false,
                                  onShowMorePressed:
                                      model.onPressShowMoreResults,
                                  height: height,
                                  page: model.page,
                                  totalPages: model.totalPages,
                                ),
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
