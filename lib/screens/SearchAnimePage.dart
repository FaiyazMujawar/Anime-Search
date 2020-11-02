import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../Constants.dart';
import '../components/AnimeCard.dart';
import '../data_access/AnimeData.dart';

class SearchAnimePage extends StatefulWidget {
  @override
  _SearchAnimePageState createState() => _SearchAnimePageState();
}

class _SearchAnimePageState extends State<SearchAnimePage> {
  Widget _body;
  String animeName;
  @override
  void initState() {
    super.initState();
    _body = Container();
    animeName = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          animeName = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.red,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                          ),
                        ),
                        hintText: 'Search Anime',
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
                RaisedButton.icon(
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    buildSearchAnimePage();
                  },
                  color: Colors.orange,
                  icon: Icon(
                    Feather.search,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: Text(
                    'Search',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: _body,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> buildSearchAnimePage() async {
    List<Map<String, dynamic>> animes = await getAnimeByName(animeName);

    List<Widget> searchAnimePageContents = <Widget>[
      Text(
        'Search Results',
        style: kHeadingTextStyle,
      ),
    ];

    setState(() {
      _body = Expanded(
        child: ListView.builder(
          itemCount: searchAnimePageContents.length,
          itemBuilder: (context, index) {
            return searchAnimePageContents[index];
          },
        ),
      );
    });

    for (var anime in animes) {
      searchAnimePageContents.add(
        AnimeCard(
          anime: anime,
        ),
      );
    }
    setState(
      () {
        _body = Expanded(
          child: ListView.builder(
            itemCount: searchAnimePageContents.length,
            itemBuilder: (context, index) {
              return searchAnimePageContents[index];
            },
          ),
        );
      },
    );
  }
}
