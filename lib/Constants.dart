import 'package:flutter/material.dart';

/* Anime Card */

const kHeadingTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w900,
);

const kTitleTextStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold,
);

const kTitleBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(10),
  ),
  color: Colors.white,
);

var kAnimeCardDecoration = (String imgURL) => BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 30,
          color: Color(0xFFB7B7B7).withOpacity(0.7),
        ),
      ],
      image: DecorationImage(
        image: NetworkImage(imgURL),
        alignment: Alignment.topCenter,
        fit: BoxFit.fill,
      ),
    );
