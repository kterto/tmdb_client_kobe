import 'package:flutter/material.dart';
import 'package:tmdb_client_kobe/src/util/form_control.dart';

class SearchField extends StatelessWidget {
  final double borderRadius;
  final double inputWidth;
  final double inputHeight;
  final double fontSize;
  final String hint;
  final Widget prefixAsset;
  final TextInputType keyboradType;
  final Function onChanged;
  final FormControl formControl;
  final String label;
  final Function onSearchPressed;

  SearchField({
    this.borderRadius,
    this.inputWidth,
    this.inputHeight = 49,
    this.fontSize,
    this.hint,
    this.prefixAsset,
    this.keyboradType,
    this.onChanged,
    this.formControl,
    this.label,
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inputWidth,
      height: inputHeight,
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        top: 10,
      ),
      child: TextFormField(
        onChanged: onChanged,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: fontSize,
        ),
        keyboardType: keyboradType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          contentPadding: EdgeInsets.only(
            left: 5,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          //   prefixIcon: prefixAsset,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: onSearchPressed,
          ),
          errorText: formControl.errorMessage,
        ),
      ),
    );
  }
}
