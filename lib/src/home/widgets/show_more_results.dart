import 'package:flutter/material.dart';

class ShowMoreResults extends StatelessWidget {
  final Function onShowMorePressed;
  final double height;

  ShowMoreResults({
    this.height,
    this.onShowMorePressed,
  });

  Widget build(context) {
    return InkWell(
      onTap: onShowMorePressed,
      child: Container(
        color: Color.fromARGB(100, 0, 0, 0),
        height: 0.1 * height,
        margin: EdgeInsets.only(bottom: 0.15 * height),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Show more Results '),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
