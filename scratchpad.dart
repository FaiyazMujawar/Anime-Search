import 'dart:convert';
import 'package:anime_search/data_access/anime_data.dart';

main(List<String> args) async {
  dynamic data = await getAnimeById(30276);
  print(JsonEncoder.withIndent('  ').convert(data));
}
