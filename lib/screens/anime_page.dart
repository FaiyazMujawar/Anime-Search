import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../Constants.dart';
import '../components/score_tile.dart';
import '../data_access/anime_data.dart';
import '../components/subtitled_image.dart';
import '../components/anime_episode_card.dart';
import '../components/no_internet_widget.dart';

class AnimePage extends StatefulWidget {
  final int id;

  const AnimePage({Key key, @required this.id}) : super(key: key);
  @override
  _AnimePageState createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  int id;
  Widget _body;
  bool _hasConnection;
  List<Widget> animePageContents;
  @override
  void initState() {
    super.initState();
    id = widget.id;
    _hasConnection = null;
    _body = Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _hasConnection == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _hasConnection ? _body : NoInternetWidget(),
      ),
    );
  }

  void checkConnection() async {
    bool hasConnection = await DataConnectionChecker().hasConnection;
    setState(() {
      _hasConnection = hasConnection;
      buildAnimePage();
    });
  }

  Future<void> buildAnimePage() async {
    animePageContents = <Widget>[];

    // Get & display basic anime details.
    Map<String, dynamic> anime = await getAnimeById(id);
    animePageContents.addAll(
      [
        // Name of the anime.
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(
              bottom: 5,
              top: 20,
            ),
            child: Text(
              anime['title'],
              style: kHeadingTextStyle,
            ),
          ),
          subtitle: ScoreTile(
            score: anime['score'],
            text: anime['rating'],
          ),
        ),
        // Anime Image
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Card(
            elevation: 10,
            child: Image.network(
              anime['image_url'],
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        // Synopsis
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),
              child: Text(
                'About',
                style: kTitleTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Text(
                anime['about'],
                style: kBodyTextStyle,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
    buildListView();

    // Get & display anime's main characters.
    List<Map<String, dynamic>> mainCharacters =
        await getMainCharactersByAnimeId(id);
    animePageContents.addAll(
      [
        // Anime's main characters
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Text(
                  'Main Characters',
                  style: kTitleTextStyle,
                ),
              ),
              Container(
                height: 300,
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: mainCharacters.length,
                  itemBuilder: (context, index) {
                    return SubtitledImage(
                      url: mainCharacters[index]['url'],
                      subtitle: mainCharacters[index]['name'],
                      height: 200.0,
                      width: 170.0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
    buildListView();

    // Get & display anime's episodes list.
    Map<String, dynamic> episodesList = await getEpisodesByAnimeId(id);
    List<Map<String, dynamic>> episodes = episodesList['episodes'];
    animePageContents.addAll(
      [
        // Anime's episodes list
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Episodes',
                style: kTitleTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
    if (episodes.length == 0) {
      animePageContents.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Card(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Center(
                child: Text(
                  'Error getting episodes list.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      animePageContents.addAll(episodes
          .map(
            (episode) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AnimeEpisodeCard(
                name: episode['title'],
                url: episode['url'],
                id: episode['id'],
              ),
            ),
          )
          .toList());
    }
    animePageContents.add(
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: ListTile(
          title: Text(
            'Learn more',
            style: kTitleTextStyle,
          ),
          trailing: IconButton(
            icon: Icon(
              Ionicons.ios_arrow_forward,
              color: Colors.blue.shade800,
            ),
            onPressed: () {
              print('object');
            },
          ),
        ),
      ),
    );
    buildListView();
  }

  void buildListView() {
    setState(() {
      _body = Container(
        child: ListView.builder(
            itemCount: animePageContents.length,
            itemBuilder: (context, index) => animePageContents[index]),
      );
    });
  }
}
