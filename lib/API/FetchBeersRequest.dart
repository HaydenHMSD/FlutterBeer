import '../Data/Beer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Beer>> fetchBeers() async {
  var path = 'api.punkapi.com';
  final response = await http.get(Uri.https(path, '/v2/beers'));

  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    List<Beer> beers = List<Beer>.from(l.map((e) => Beer.fromJson(e)));
    return beers;
  } else {
    throw Exception('failed to load beers');
  }
}