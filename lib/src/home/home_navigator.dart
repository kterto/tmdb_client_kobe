import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/views/details_view.dart';
import 'package:tmdb_client_kobe/src/home/views/home_view.dart';

typedef RouteGenerator = MaterialPageRoute Function();

class HomeNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  HomeNavigator({this.navigatorKey});

  State<HomeNavigator> createState() => HomeNavigatorState();
}

class HomeNavigatorState extends State<HomeNavigator> {
  GlobalKey<NavigatorState> navigatorKey;
  Map<String, RouteGenerator> _routes;

  void initState() {
    super.initState();
    navigatorKey = widget.navigatorKey;

    _routes = {
      '/': () => MaterialPageRoute(
            settings: RouteSettings(name: '/home'),
            builder: (context) => HomeView(),
          ),
      '/details': () => MaterialPageRoute(
            settings: RouteSettings(name: '/details'),
            builder: (context) => DetailsView(),
          ),
    };
  }

  Route _homeRoutes(RouteSettings settings) {
    final newRouteName = settings.name;

    print('[homeRoutes][name]: $newRouteName');
    if (_routes.containsKey(newRouteName)) return _routes[newRouteName]();

    return _routes['/home']();
  }

  Widget build(context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: _homeRoutes,
    );
  }
}
