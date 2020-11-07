import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../components/anime_card.dart';
import '../data_access/anime_data.dart';
import '../components/no_internet_widget.dart';

class SearchAnimePage extends StatefulWidget {
  @override
  _SearchAnimePageState createState() => _SearchAnimePageState();
}

class _SearchAnimePageState extends State<SearchAnimePage> {
  Widget _body;
  bool _hasConnection;
  String _animeName;
  @override
  void initState() {
    super.initState();
    _hasConnection = null;
    _body = Container();
    _animeName = '';
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        child: _hasConnection == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _hasConnection
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  _animeName = value;
                                },
                                cursorColor: kAccentColor,
                                cursorWidth: 1.5,
                                decoration: kInputDecorationStyle,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              buildSearchAnimePage();
                            },
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: kAccentColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          child: _body,
                        ),
                      ),
                    ],
                  )
                : NoInternetWidget(),
      ),
    );
  }

  void checkConnection() async {
    bool hasConnection = await DataConnectionChecker().hasConnection;
    setState(() {
      _hasConnection = hasConnection;
    });
  }

  Future<void> buildSearchAnimePage() async {
    setState(() {
      _body = Center(child: CircularProgressIndicator());
    });
    List<Widget> searchAnimePageContents = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Text(
          'Search Results',
          style: kHeadingTextStyle,
        ),
      ),
    ];

    List<Map<String, dynamic>> animes = await getAnimeByName(_animeName);

    if (animes.length == 0) {
      setState(() {
        _body = Center(
          child: Text(
            'No anime found!',
          ),
        );
      });
      return;
    }

    searchAnimePageContents.removeLast();

    for (var anime in animes) {
      searchAnimePageContents.add(
        AnimeCard(
          anime: anime,
        ),
      );
    }

    setState(
      () {
        _body = ListView.builder(
          itemCount: searchAnimePageContents.length,
          itemBuilder: (context, index) {
            return searchAnimePageContents[index];
          },
        );
      },
    );
  }
}
