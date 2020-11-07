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

    int count = 0;

    for (var anime in data) {
      if (count++ > 20) break;
      score = anime["score"] / 2;
      topAnimes.add(
        {
          'id': anime['mal_id'],
          'title': anime['title'],
          'image_url': anime['image_url'],
          'episodes': anime['episodes'],
          'score': score.toStringAsFixed(1),
        },
      );
    }
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

    int count = 0;

    for (var anime in data) {
      if (count++ > 20) break;
      score = anime["score"] / 2;
      animes.add(
        {
          'id': anime['mal_id'],
          'title': anime['title'],
          'image_url': anime['image_url'],
          'episodes': anime['episodes'],
          'score': score.toStringAsFixed(1),
        },
      );
    }
  } catch (e) {
    print(e.toString());
  }

  return animes;
}

/**
 * Returns the Anime with specified [id]
 */
Future<Map<String, dynamic>> getAnimeById(int id) async {
  Map<String, dynamic> anime;
  dynamic animeData;

  try {
    // Get anime data
    animeData = (jsonDecode(
      (await get('https://api.jikan.moe/v3/anime/$id')).body,
    ));

    double score = animeData['score'] / 2;

    anime = {
      'id': animeData['mal_id'],
      'url': animeData['url'],
      'title': animeData['title'],
      'image_url': animeData['image_url'],
      'about': animeData['synopsis'],
      'type': animeData['type'],
      'score': score.toStringAsFixed(1),
      'rating': animeData['rating'],
      'episodes_count': animeData['episodes'],
    };
  } catch (e) {
    print(e.toString());
    print(e.osError);
  }

  return anime;
}

/**
 * Returns list of main characters of anime with specified [id]
 */
Future<List<Map<String, dynamic>>> getMainCharactersByAnimeId(int id) async {
  List<Map<String, dynamic>> mainCharacters = new List();

  dynamic characters;
  try {
    // Get anime's main characters
    characters = (jsonDecode(
      (await get('https://api.jikan.moe/v3/anime/$id/characters_staff')).body,
    ))['characters'];

    // Only passing the name & image URL of the main characters.
    characters.retainWhere((character) => character['role'] == 'Main');
    for (var character in characters) {
      mainCharacters.add(
        {
          'name': character['name'],
          'url': character['image_url'],
        },
      );
    }
  } catch (e) {
    print(e.toString());
  }

  return mainCharacters;
}

/**
 * Returns list of episodes of anime with specified [id]
 */
Future<Map<String, dynamic>> getEpisodesByAnimeId(int id) async {
  List<Map<String, dynamic>> episodesList = new List();
  dynamic episodes;
  try {
    // Get anime's episodes
    episodes = jsonDecode(
      (await get('https://api.jikan.moe/v3/anime/$id/episodes')).body,
    );

    // Only passing the episode ID, title & video URL.
    for (var episode in episodes['episodes']) {
      episodesList.add(
        {
          'id': episode['episode_id'],
          'title': episode['title'],
          'url': episode['video_url'],
        },
      );
    }
  } catch (e) {
    print(e.toString());
  }

  bool hasMoreEpisodes = episodes['episodes_last_page'] > 1;

  return {
    'hasMoreEpisodes': hasMoreEpisodes,
    'episodes': episodesList,
  };
}
