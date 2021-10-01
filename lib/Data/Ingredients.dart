import 'Ingredient.dart';

class Ingredients {
  final String? yeast;
  late final List<Ingredient>? malts;
  late final List<Ingredient>? hops;

  Ingredients({
    required this.yeast,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    // - ingredients
    var ingredients = Ingredients(
      yeast: json['yeast'],
    );

    // - malts
    List<dynamic> maltInfos = json['malt'];
    var malts = maltInfos.map((info) => Ingredient.fromJson(info));
    ingredients.malts = List.from(malts);

    // - hops
    List<dynamic> hopsInfos = json['hops'];
    var hops = hopsInfos.map((info) => Ingredient.fromJson(info));
    ingredients.hops = List.from(hops);

    return ingredients;
  }

  List<String> panelDetails() {
    return ['Yeast: $yeast'];
  }
}