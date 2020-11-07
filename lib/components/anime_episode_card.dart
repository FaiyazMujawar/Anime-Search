import 'package:anime_search/data_access/anime_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../Constants.dart';

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
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(
                bottom: 5,
              ),
              child: Text(
                name,
                style: kNameTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            subtitle: Text(
              'Episode $id',
              style: kSubtitleTextStyle,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.open_in_new,
                color: kAccentColor,
              ),
              onPressed: () async {
                if ((await launchURL(url))) {
                  Scaffold.of(context).showSnackBar(
                    kSnackBar('Please switch to desktop mode!'),
                  );
                } else {
                  Scaffold.of(context).showSnackBar(
                    kSnackBar('Oops! Unable to open the episode!'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
