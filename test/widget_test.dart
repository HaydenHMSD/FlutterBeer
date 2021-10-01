// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:beer_app/Scenes/BeerList/BeerListWidget.dart';
import 'package:beer_app/Data/Amount.dart';

void main() {
  test('Decrypt Amount', () async {
    final json = {
      'value': 200,
      'unit': 'mL',
    };
    final amount = Amount.fromJson(json);
    expect(amount.unit, 'mL');
    expect(amount.value, 200.0);
  });
}
