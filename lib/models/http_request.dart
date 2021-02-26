import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'album_model.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client, String url) async {
  final response = await client.get(url);

  return compute(parsePhotos, response.body);
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}
