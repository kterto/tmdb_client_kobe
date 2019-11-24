import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  Widget build(context) {
    return Container(
      color: Color(0xFF081C24),
      child: Center(
        child: Image.asset(
          'tmdb_logo.png',
          width: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
    );
  }
}
