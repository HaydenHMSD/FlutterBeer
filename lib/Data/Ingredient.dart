import 'Amount.dart';

class Ingredient {
  final String? name;
  final String? add;
  final String? attribute;
  Amount? amount;

  Ingredient({
    required this.name,
    this.add,
    this.attribute,
    this.amount,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    var ingredient = Ingredient(
        name: json['name'],
        add: json['add'],
        attribute: json['attribute'],
        amount: Amount.fromJson(json['amount'])
    );

    return ingredient;
  }
}