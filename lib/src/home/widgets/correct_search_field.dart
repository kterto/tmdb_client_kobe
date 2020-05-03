import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_client_kobe/src/home/blocs/search/search_bloc.dart';

class CorrectSearchField extends StatefulWidget {
  final double borderRadius;
  final double inputWidth;
  final double inputHeight;
  final double fontSize;
  final String hint;
  final Widget prefixAsset;
  final TextInputType keyboradType;
  final String label;

  CorrectSearchField({
    @required this.borderRadius,
    @required this.fontSize,
    @required this.hint,
    @required this.keyboradType,
    this.inputWidth,
    this.prefixAsset,
    this.label,
    this.inputHeight = 49,
  });

  @override
  _CorrectSearchFieldState createState() => _CorrectSearchFieldState();
}

class _CorrectSearchFieldState extends State<CorrectSearchField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.inputWidth,
      height: widget.inputHeight,
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        top: 10,
      ),
      child: TextFormField(
        controller: controller,
        onChanged: (String value) {},
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: widget.fontSize,
        ),
        keyboardType: widget.keyboradType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          contentPadding: EdgeInsets.only(
            left: 5,
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          //   prefixIcon: prefixAsset,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              onSearchPressed();
            },
          ),
        ),
      ),
    );
  }

  void onSearchPressed() {
    BlocProvider.of<SearchBloc>(context).add(SearchMovie(controller.text));
  }
}
