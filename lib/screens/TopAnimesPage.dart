// import 'package:anime_search/data_access/AnimeData.dart';
import 'package:anime_search/Constants.dart';
import 'package:anime_search/components/AnimeCard.dart';
import 'package:anime_search/data_access/AnimeData.dart';
import 'package:flutter/material.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  List<Widget> _topAnimes;
  @override
  void initState() {
    super.initState();
    _topAnimes = <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 15, 10),
        child: Text(
          "Top Animes",
          style: kHeadingTextStyle,
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ];
    setTopAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView.builder(
          itemCount: _topAnimes.length,
          itemBuilder: (context, index) {
            return _topAnimes[index];
          },
        ),
      ),
    );
  }

  Future<void> setTopAnimes() async {
    List<Map<String, dynamic>> animes = await getTopAnimes();
    for (var anime in animes) {
      _topAnimes.add(AnimeCard(anime: anime));
    }
    setState(() {});
  }
}
