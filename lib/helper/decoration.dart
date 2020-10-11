import 'package:flutter/material.dart';

InputDecoration textInputDecoration(String labelTExt) {
  return InputDecoration(
      labelText: labelTExt,
      labelStyle: TextStyle(
        color: Colors.brown,
        fontSize: 16,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueGrey,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Colors.teal,
      )));
}
