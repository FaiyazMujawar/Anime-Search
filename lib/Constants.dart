import 'package:flutter/material.dart';

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

var kBoxShadow = [
  BoxShadow(
    offset: Offset(0, 2),
    blurRadius: 10,
    color: Colors.grey.withOpacity(0.5),
  ),
];

Function kAnimeCardDecoration = (String imgURL) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    boxShadow: kBoxShadow,
    image: DecorationImage(
      image: NetworkImage(imgURL),
      alignment: Alignment.topCenter,
      fit: BoxFit.fill,
    ),
  );
};
