import 'dart:convert';
import 'package:http/http.dart';

/**
 * Returns a list with details of top rated animes.
 */
Future<List<Map<String, dynamic>>> getTopAnimes() async {
  List<Map<String, dynamic>> topAnimes = [];
  dynamic data;
  double score = 0.0;

  try {
    data = (jsonDecode(
      (await get('https://api.jikan.moe/v3/top/anime/')).body,
    ))['top'];

    data.forEach(
      (anime) {
        score = anime["score"] / 2;
        topAnimes.add(
          {
            'id': anime['mal_id'],
            'url': anime['url'],
            'title': anime['title'],
            'image_url': anime['image_url'],
            'type': anime['type'],
            'episodes': anime['episodes'],
            'score': score.toStringAsFixed(1),
          },
        );
      },
    );
  } catch (e) {
    print(e.toString());
  }

  return topAnimes;
}

/**
 * Returns a list with details of animes related to the specified [name].
 */
Future<List<Map<String, dynamic>>> getAnimeByName(String name) async {
  name = name.toLowerCase().replaceAll(' ', '-');

  dynamic data;
  double score = 0.0;

  List<Map<String, dynamic>> animes = new List();

  try {
    data = (jsonDecode(
      (await get('https://api.jikan.moe/v3/search/anime?q=$name')).body,
    ))['results'];

    data.forEach(
      (anime) {
        score = anime['score'] / 2;
        print(score);
        animes.add(
          {
            'id': anime['mal_id'],
            'url': anime['url'],
            'title': anime['title'],
            'image_url': anime['image_url'],
            'about': anime['synosis'],
            'type': anime['type'],
            'episodes': anime['episodes'],
            'score': score.toStringAsFixed(1),
            'rating': anime['rated']
          },
        );
      },
    );
  } catch (e) {
    print(e.toString());
  }

  return animes;
}

Future<Map<String, dynamic>> getAnimeById(int id) async {
  Map<String, dynamic> anime;
  dynamic animeData, characters, episodes;

  try {
    // Get anime data
    animeData = (jsonDecode(
      (await get('https://api.jikan.moe/v3/anime/$id')).body,
    ));

    // Get anime's main characters
    characters = (jsonDecode(
      (await get('https://api.jikan.moe/v3/anime/$id/characters_staff')).body,
    ))['characters'];

    // Get anime's episodes
    episodes = (jsonDecode(
      (await get('https://api.jikan.moe/v3/anime/$id/episodes')).body,
    ))['episodes'];

    // Only passing the name & image URL of the main characters.
    characters.retainWhere((character) => character['role'] == 'Main');
    characters = characters
        .map(
          (character) => {
            'name': character['name'],
            'url': character['image_url'],
          },
        )
        .toList();

    // Only passing the episode ID, title & video URL.
    episodes = episodes
        .map(
          (episode) => {
            'id': episode['episode_id'],
            'title': episode['title'],
            'url': episode['video_url'],
          },
        )
        .toList();

    anime = {
      'id': animeData['mal_id'],
      'url': animeData['url'],
      'title': animeData['title'],
      'image_url': animeData['image_url'],
      'about': animeData['synopsis'],
      'type': animeData['type'],
      'score': (animeData['score']).toStringAsFixed(1),
      'rating': animeData['rating'],
      'main_characters': characters,
      'episodes': episodes,
    };
  } catch (e) {
    print(e.toString());
  }

  return anime;
}
