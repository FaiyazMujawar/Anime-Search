import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AnimeEpisodeCard extends StatelessWidget {
  const AnimeEpisodeCard({
    Key key,
    this.name,
    this.id,
    this.url,
    this.action,
  }) : super(key: key);

  final String name;
  final int id;
  final String url;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Episode $id',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  SimpleLineIcons.arrow_right_circle,
                  size: 25,
                  color: Colors.blue[500],
                ),
                onPressed: action,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// anime['episodes'][index]['title']
// anime['episodes'][index]['url']
