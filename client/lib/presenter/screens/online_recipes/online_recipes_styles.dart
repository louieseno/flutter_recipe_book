import 'package:flutter/material.dart';

class OnlineRecipeStyles {
  static final searchBoxstyle = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[400]),
      hintText: "Search Recipe",
      fillColor: Colors.white70);

  static const containerPadding = EdgeInsets.all(16.0);

  static const listPadding =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0);

  static const labelPadding = EdgeInsets.only(left: 10);

  static const labelStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700);

  static const dishTypeStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

  static const ingredientsStyle =
      TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400);

  static const ingedientsTotalStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: Colors.pinkAccent);

  static const saveButtonStyle =
      EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0);
}
