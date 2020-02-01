import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/home_navigator.dart';
import 'package:tmdb_client_kobe/src/util/custom_navigation_observer.dart';
import 'package:tmdb_client_kobe/src/util/splash_screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

typedef RouteGenerator = MaterialPageRoute Function();

class _AppState extends State<App> {
  CustomNavigatorObserver _navigatorObserver;
  Map<String, RouteGenerator> _routes;
  GlobalKey<NavigatorState> homeNavigatorKey;

  void initState() {
    super.initState();
    _navigatorObserver = CustomNavigatorObserver();
    homeNavigatorKey = GlobalKey<NavigatorState>();
    _initRoutes();
  }

  void _initRoutes() {
    _routes = {
      '/home': () => MaterialPageRoute(
            settings: RouteSettings(name: '/home'),
            builder: (context) => HomeNavigator(navigatorKey: homeNavigatorKey),
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [_navigatorObserver],
      onGenerateRoute: _appRoutes,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFF081C24),
        ),
        primaryColor: Color(0xFF01D277),
        accentColor: Color(0xFF01D277),
        fontFamily: "OpenSans",
      ),
      home: SplashScreen(),
    );
  }

  Route _appRoutes(RouteSettings settings) {
    final newRouteName = settings.name;
    if (_routes.containsKey(newRouteName)) return _routes[newRouteName]();

    return _routes['/home']();
  }
}
