import 'screens/main_screen.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Search',
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryColor,
        cardColor: kSecondaryColor,
        accentColor: kAccentColor,
      ),
      home: MainScreen(),
    );
  }
}
