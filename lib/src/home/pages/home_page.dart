import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:tmdb_client_kobe/src/home/pages/search_page.dart';
import 'package:tmdb_client_kobe/src/home/stores/home_store.dart';
import 'package:tmdb_client_kobe/src/home/widgets/movies_card_grid.dart';
import 'package:tmdb_client_kobe/src/locator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore _store = locator<HomeStore>();
  final ScrollController viewScroller = ScrollController();

  @override
  void initState() {
    viewScroller.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (viewScroller.position.atEdge &&
        viewScroller.position.extentAfter == 0) {
      _store.getUpcoming();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upcoming",
          style: TextStyle(
            color: Color(0xFFAAAAAA),
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(SearchPage()),
        child: Icon(Icons.search),
      ),
      body: Observer(
        builder: (_) {
          if (_store.upcomingList == null) {
            _store.getUpcoming();
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (_store.getUpcomingErrorMessage != null) {
              return Center(
                child: Text(_store.getUpcomingErrorMessage),
              );
            } else {
              return MoviesCardGrid(
                moviesList: _store.upcomingList,
                setDetails: null,
                isHome: true,
                isMobX: true,
                viewScroller: viewScroller,
                height: MediaQuery.of(context).size.height,
              );
            }
          }
        },
      ),
    );
  }
}
