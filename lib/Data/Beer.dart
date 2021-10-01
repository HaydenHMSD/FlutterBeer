import 'Ingredients.dart';

class Beer {
  final int? id;
  final String? name;
  final String? tagline;
  final String? firstBrewed;
  final String? description;
  final String? imagePath;
  late final Ingredients? ingredients;

  Beer({
    required this.id,
    required this.name,
    required this.tagline,
    required this.firstBrewed,
    required this.description,
    required this.imagePath,
  });

  factory Beer.fromJson(Map<String, dynamic> json) {
    var beer = Beer(
      id: json['id'],
      name: json['name'],
      tagline: json['tagline'],
      firstBrewed: json['first_brewed'],
      description: json['description'],
      imagePath: json['image_url'],
    );
    beer.ingredients = Ingredients.fromJson(json['ingredients']);
    return beer;
  }

  String panelDetails() {
    return '$tagline\n\nFirst Brewed: $firstBrewed\n\n$description';
  }
}