class EdamamRecipe {
  String id;
  String label;
  String image;
  String dishType;
  List<String> ingredients;

  EdamamRecipe({
    required this.id,
    required this.label,
    required this.image,
    required this.dishType,
    required this.ingredients,
  });

  factory EdamamRecipe.fromJson(Map<String, dynamic> json) {
    return EdamamRecipe(
      id: json['uri'].split('#')[1],
      label: json['label'],
      image: json['image'],
      dishType: json['dishType'][0],
      ingredients: List<String>.from(json['ingredientLines']),
    );
  }

  static List<EdamamRecipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((item) {
      return EdamamRecipe.fromJson(item);
    }).toList();
  }
}
