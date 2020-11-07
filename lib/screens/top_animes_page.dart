import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../components/anime_card.dart';
import '../data_access/anime_data.dart';
import '../components/no_internet_widget.dart';

class TopAnimesPage extends StatefulWidget {
  @override
  _TopAnimesPageState createState() => _TopAnimesPageState();
}

class _TopAnimesPageState extends State<TopAnimesPage> {
  Widget _body;
  bool _hasConnection;
  @override
  void initState() {
    super.initState();
    _body = Center(
      child: CircularProgressIndicator(),
    );
    _hasConnection = null;
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _hasConnection == null
          ? Center(child: CircularProgressIndicator())
          : _hasConnection ? _body : NoInternetWidget(),
    );
  }

  void checkConnection() async {
    bool hasConnection = await DataConnectionChecker().hasConnection;
    setState(() {
      _hasConnection = hasConnection;
      if (_hasConnection) buildTopAnimesPage();
    });
  }

  Future<void> buildTopAnimesPage() async {
    List<Map<String, dynamic>> animes;

    animes = await getTopAnimes();

    List<Widget> topAnimesPageContents = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Text(
          "Top Animes",
          style: kHeadingTextStyle,
        ),
      ),
    ];

    for (var anime in animes) {
      topAnimesPageContents.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AnimeCard(
            anime: anime,
          ),
        ),
      );
    }

    if (this.mounted)
      setState(
        () {
          _body = ListView.builder(
            itemCount: topAnimesPageContents.length,
            itemBuilder: (context, index) => topAnimesPageContents[index],
          );
        },
      );
  }
}
