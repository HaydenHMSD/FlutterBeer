import 'package:flutter_test/flutter_test.dart';
import 'package:beer_app/Data/DataManager.dart';

void main() {
  test('data save', () {
    final dataManager = DataManager();
    dataManager.saveFavorite(1);

  });
}
