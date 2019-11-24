import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/home/view_models/details_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view.dart';

class DetailsView extends StatelessWidget {
  Widget build(context) {
    return BaseView<DetailsModel>(
      onModelReady: (model) => model.initModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.movie.title,
              style: TextStyle(
                color: Color(0xFFAAAAAA),
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
