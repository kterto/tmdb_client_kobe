import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  final _onRouteChange = PublishSubject<Route>();

  Route _route;

  Route get route => _route;

  Observable<Route> get onRouteChange => _onRouteChange.stream;

  CustomNavigatorObserver() {
    evaluateRoute();
  }

  void evaluateRoute() async {
    await Future.delayed(Duration(milliseconds: 1200));

    navigator.pushReplacementNamed('/home');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    _updateRoute(route);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    if (_route == oldRoute) {
      _updateRoute(newRoute);
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    _updateRoute(previousRoute);
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    if (route == _route) {
      _updateRoute(previousRoute);
    }
  }

  void _updateRoute(Route route) {
    _route = route;
    _onRouteChange.add(route);
  }
}
