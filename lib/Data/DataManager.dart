

import 'package:shared_preferences/shared_preferences.dart';

 class DataManager {
  final _favoriteKey = 'favoriteIDs';

  Future<List<int>> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var favoriteIDs = prefs.getStringList(_favoriteKey);
    if (favoriteIDs != null) {
      return List<int>.from(favoriteIDs.map((e) => int.parse(e)));
    }
    return List<int>.empty();
  }

  List<int> _mutableIDs(SharedPreferences prefs) {
    var favoriteIDs = prefs.getStringList(_favoriteKey);
    late List<int> ids;
    if (favoriteIDs != null) {
      return List<int>.from(favoriteIDs.map((e) => int.parse(e)), growable: true);
    } else {
      return List<int>.empty(growable: true);
    }
  }
  Future<List<int>> toggleFavorite(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ids = _mutableIDs(prefs);
    if (ids.contains(id)) {
      ids.remove(id);
    } else {
      ids.add(id);
    }

    final idStrings = List<String>.from(ids.map((e) => e.toString()));

    await prefs.setStringList(_favoriteKey, idStrings);

    return ids;
  }
  Future<List<int>> saveFavorite(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var ids = _mutableIDs(prefs);
    ids.add(id);

    final idStrings = List<String>.from(ids.map((e) => e.toString()));

    await prefs.setStringList(_favoriteKey, idStrings);

    return ids;
  }

  Future<List<int>> removeFavorite(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var ids = _mutableIDs(prefs);
    if (ids.contains(id)) {
      ids.remove(id);
    }

    final idStrings = List<String>.from(ids.map((e) => e.toString()));

    await prefs.setStringList(_favoriteKey, idStrings);
    return ids;
  }
}