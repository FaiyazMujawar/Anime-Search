import 'package:flutter/material.dart';

import '../Constants.dart';
import '../components/AnimeCard.dart';
import '../data_access/AnimeData.dart';

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  Widget _body;
  @override
  void initState() {
    super.initState();
    _body = Container();
    buildTopAnimesPage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: _body,
      ),
    );
  }

  Future<void> buildTopAnimesPage() async {
    List<Map<String, dynamic>> animes = await getTopAnimes();

    List<Widget> topAnimesPageContents = <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 15, 10),
        child: Text(
          "Top Animes",
          style: kHeadingTextStyle,
        ),
      ),
    ];

    for (var anime in animes) {
      topAnimesPageContents.add(
        AnimeCard(
          anime: anime,
        ),
      );
    }
    setState(
      () {
        _body = ListView.builder(
          itemCount: topAnimesPageContents.length,
          itemBuilder: (context, index) {
            return topAnimesPageContents[index];
          },
        );
      },
    );
  }
}
