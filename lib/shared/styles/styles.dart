import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.ptSerif(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
  );
}

TextStyle get categoryStyle {
  return GoogleFonts.ptSerif(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.white
    ),
  );
}
TextStyle get subTitleStyle {
  return GoogleFonts.openSans(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.openSans(
    textStyle: TextStyle(
        fontSize: 16,
    ),
  );
}

TextStyle get priceStyle {
  return GoogleFonts.openSans(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    ),
  );
}

