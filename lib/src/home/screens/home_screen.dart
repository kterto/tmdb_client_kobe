import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tmdb_client_kobe/src/home/blocs/home/home_bloc_barrel.dart';
import 'package:tmdb_client_kobe/src/home/screens/search_screen.dart';
import 'package:tmdb_client_kobe/src/home/widgets/movies_card_grid.dart';
import 'package:tmdb_client_kobe/src/locator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc bloc = locator<HomeBloc>();
  final ScrollController viewScroller = ScrollController();
  final _scrollThreshold = 200.0;
  double maxScroll;

  @override
  void initState() {
    viewScroller.addListener(_onScroll);
    super.initState();
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
        onPressed: () => Get.to(SearchScreen()),
        child: Icon(Icons.search),
      ),
      body: BlocProvider<HomeBloc>.value(
        value: bloc,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Builder(
              builder: (context) {
                switch (state.runtimeType) {
                  case InitialState:
                    bloc.add(FetchNextPage());
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case LoadedUpcoming:
                    return MoviesCardGrid(
                      moviesList: (state as LoadedUpcoming).upcomingList,
                      setDetails: null,
                      isHome: true,
                      isBloc: true,
                      viewScroller: viewScroller,
                      height: MediaQuery.of(context).size.height,
                    );
                    break;
                  case FetchUpcomingError:
                    return Center(
                      child: Text((state as FetchUpcomingError).message),
                    );
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

  void _onScroll() {
    if (viewScroller.position.atEdge &&
        viewScroller.position.extentAfter == 0) {
      bloc.add(FetchNextPage());
    }
  }

  void dispose() {
    super.dispose();
    bloc.close();
  }
}
