import 'package:flutter/material.dart';

class OptionTextStyle {
  optionStyle([double? siz, Color? clr, FontWeight? ftWeight, TextDecoration? decoration]) {
    return TextStyle(fontSize: siz, fontWeight: ftWeight, fontFamily: 'Roboto', color: clr, decoration: decoration);
  }

  optionStyle2([double? siz, Color? clr, FontWeight? ftWeight]) {
    return TextStyle(fontSize: siz, fontWeight: ftWeight, fontFamily: 'Roboto', color: clr);
  }

  optionStyle3() {
    return TextStyle(fontFamily: 'Roboto');
  }
}
