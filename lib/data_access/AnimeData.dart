import 'dart:convert';
import 'package:http/http.dart';

/**
 * Returns a list with details of top rated animes.
 */
Future<List<Map<String, dynamic>>> getTopAnimes() async {
  List<Map<String, dynamic>> topAnimes = [];
  Response response;
  dynamic data;
  double score = 0.0;

  try {
    response = await get('https://api.jikan.moe/v3/top/anime/');
    data = jsonDecode(response.body);

    data = data['top'];
    data.forEach((anime) {
      score = anime["score"] / 2;
      topAnimes.add({
        'id': anime['mal_id'],
        'url': anime['url'],
        'title': anime['title'],
        'image_url': anime['image_url'],
        'type': anime['type'],
        'episodes': anime['episodes'],
        'score': score.toStringAsFixed(1),
      });
    });
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

  Response response;
  dynamic data;
  double score = 0.0;

  List<Map<String, dynamic>> animes = new List();

  try {
    response = await get('https://api.jikan.moe/v3/search/anime?q=$name');
    data = jsonDecode(response.body);
    data = data['results'];
    data.forEach((anime) {
      score = anime['score'] / 2;
      print(score);
      animes.add({
        'id': anime['mal_id'],
        'url': anime['url'],
        'title': anime['title'],
        'image_url': anime['image_url'],
        'about': anime['synosis'],
        'type': anime['type'],
        'episodes': anime['episodes'],
        'score': score.toStringAsFixed(1),
        'rating': anime['rated']
      });
    });
  } catch (e) {
    print(e.toString());
  }

  return animes;
}
