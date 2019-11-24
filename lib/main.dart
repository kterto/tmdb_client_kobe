import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_client_kobe/src/locator.dart';

import 'src/app.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  setUpLocator();
  runApp(App());
}
