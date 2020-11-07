import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kHeadingTextStyle = GoogleFonts.sourceSansPro(
  fontSize: 30,
  fontWeight: FontWeight.w700,
);

var kNameTextStyle = GoogleFonts.openSans(
  fontWeight: FontWeight.w600,
  fontSize: 16,
);

var kTitleTextStyle = GoogleFonts.sourceSansPro(
  fontSize: 22,
  fontWeight: FontWeight.w500,
);

var kBodyTextStyle = GoogleFonts.firaSans(
  fontSize: 14,
  height: 1.4,
  color: kTextColor,
  fontStyle: FontStyle.italic,
);

var kSubtitleTextStyle = GoogleFonts.sourceSansPro(
  fontSize: 16,
  color: kTextColor,
);

var kInputDecorationStyle = InputDecoration(
  contentPadding: const EdgeInsets.all(20),
  labelText: 'Search Anime',
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: kAccentColor,
      width: 1.5,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kAccentColor,
      width: 2,
    ),
  ),
);

// Colors

const kPrimaryColor = Color(0xFF000e2e);
const kSecondaryColor = Color(0xff2b2d45);
const kAccentColor = Color(0xffE84C56);
const kTextColor = Color(0xff7F828E);
