import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../Constants.dart';
import '../components/score_tile.dart';
import '../screens/anime_page.dart';

class AnimeCard extends StatelessWidget {
  final Map<String, dynamic> anime;

  const AnimeCard({Key key, this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        // elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(anime['image_url']),
                  fit: BoxFit.cover,
                ),
              ),
              height: 200,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    anime['title'],
                    style: kNameTextStyle,
                  ),
                ),
                subtitle: ScoreTile(
                  score: anime['score'],
                  text: '${anime['episodes']} Episodes',
                ),
                trailing: IconButton(
                  icon: Icon(
                    SimpleLineIcons.arrow_right_circle,
                    color: kAccentColor,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
