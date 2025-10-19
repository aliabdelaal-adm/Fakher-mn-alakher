import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData appTheme() {
  return ThemeData(
      primarySwatch: Colors.red,
      accentColor: Colors.orange,
      dividerColor: Colors.white,
      buttonColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white,
      hintColor: Color(0xFFd0cece));
}

const logoStyle = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 21,
    letterSpacing: 2,
    color: textColor);
