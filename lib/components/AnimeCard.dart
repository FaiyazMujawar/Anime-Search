import 'package:anime_search/screens/AnimePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../Constants.dart';

class AnimeCard extends StatefulWidget {
  final Map<String, dynamic> anime;

  const AnimeCard({Key key, this.anime}) : super(key: key);
  @override
  _AnimeCardState createState() => _AnimeCardState();
}

class _AnimeCardState extends State<AnimeCard> {
  Map<String, dynamic> anime;
  @override
  void initState() {
    anime = widget.anime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
      child: Container(
        padding: EdgeInsets.only(top: 175),
        decoration: kAnimeCardDecoration(anime['image_url']),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: kTitleBoxDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        anime['title'],
                        style: kTitleTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(anime['score']),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade700,
                          size: 17,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 10),
                          child: Text(
                            '${anime['episodes']} episodes',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  SimpleLineIcons.arrow_right_circle,
                  color: Colors.blue.shade400,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimePage(
                        id: anime['id'],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
