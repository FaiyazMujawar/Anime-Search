import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../components/AnimeEpisodeCard.dart';
import '../components/SubtitledImage.dart';
import '../Constants.dart';
import '../data_access/AnimeData.dart';

class AnimePage extends StatefulWidget {
  final int id;

  const AnimePage({Key key, this.id}) : super(key: key);
  @override
  _AnimePageState createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  int id;
  Widget _body;
  @override
  void initState() {
    super.initState();
    id = widget.id;
    _body = Container();
    buildAnimePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: _body,
        ),
      ),
    );
  }

  Future<void> buildAnimePage() async {
    Map<String, dynamic> anime = await getAnimeById(id);

    List<Widget> animePageContents = <Widget>[
      // Name of the Anime
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          anime['title'],
          style: kHeadingTextStyle,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      // Anime Rating
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            anime['score'],
          ),
          Icon(
            MaterialIcons.star,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            anime['rating'],
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      // Anime Image
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          elevation: 10,
          child: Image.network(
            anime['image_url'],
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      // Synopsis
      Column(
        children: <Widget>[
          Text("About"),
          SizedBox(
            height: 10,
          ),
          Text(
            anime['about'],
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      // Anime's main characters
      Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Main Characters',
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: anime['main_characters'].length,
                itemBuilder: (context, index) {
                  return SubtitledImage(
                    url: anime['main_characters'][index]['url'],
                    subtitle: anime['main_characters'][index]['name'],
                    height: 170.0,
                    width: 150.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Anime's episodes list
      Container(
        child: Column(
          children: [
            Text(
              'Episodes: ${anime['episodes'].length}',
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      ...anime['episodes']
          .map(
            (episode) => AnimeEpisodeCard(
              name: episode['title'],
              url: episode['url'],
              id: episode['id'],
            ),
          )
          .toList(),
    ];

    setState(
      () {
        _body = Container(
          child: ListView.builder(
            itemCount: animePageContents.length,
            itemBuilder: (context, index) {
              return animePageContents[index];
            },
          ),
        );
      },
    );
  }
}

/* 

AnimeEpisodeCard(
                  name: anime['episodes'][index]['title'],
                  url: anime['episodes'][index]['url'],
                );
              }

 */
