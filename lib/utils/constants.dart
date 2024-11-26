import 'package:flutter/material.dart';

class Constants {
  static const Duration globalDuration = Duration(milliseconds: 200);
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey previewContainer = GlobalKey();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const double globalElevation = 4.0;
  static const EdgeInsets globalPadding = EdgeInsets.symmetric(horizontal: 25);
  static String pokemonImageUrl(String id) {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";
  }
}

class ColorConstants {
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color red = Colors.red;
  static Color green = Colors.green;
  static Color blue = Colors.blue;
  static Color yellow = Colors.yellow;
  static Color grey = Colors.grey;
  static Color transparent = Colors.transparent;

  static Color darkGrey = Colors.white10;
  static Color orange = Colors.orange;
  static Color purple = Colors.purple;
  static Color cyan = Colors.cyan;
  static Color teal = Colors.teal;
  static Color indigo = Colors.indigo;
  static Color pink = Colors.pink;
  static Color brown = Colors.brown;
  static Color lime = Colors.lime;
  static Color amber = Colors.amber;
  static Color deepPurple = Colors.deepPurple;
  static Color lightBlue = Colors.lightBlue;
  static Color lightGreen = Colors.lightGreen;
  static Color highlight = Colors.grey.withOpacity(0.3);
  static Color? shimmerBaseColor = Colors.grey[300];
  static Color? shimmerHighlightColor = Colors.grey[100];
}

class ApiConstants {
  static const baseUri = 'https://pokeapi.co/api/v2/';
  static const pokemonDetailsByNumberOrName = "/pokemon/";
  static const formUri = "/pokemon-form/";
}
