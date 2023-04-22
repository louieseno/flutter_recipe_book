class EdamamRecipe {
  String label;
  String image;
  String dishType;
  List<dynamic> ingredients;

  EdamamRecipe({
    required this.label,
    required this.image,
    required this.dishType,
    required this.ingredients,
  });

  factory EdamamRecipe.fromJson(Map<String, dynamic> json) {
    return EdamamRecipe(
      label: json['label'],
      image: json['image'],
      dishType: json['dishType'][0],
      ingredients: json['ingredientLines'],
    );
  }

  static List<EdamamRecipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((item) {
      return EdamamRecipe.fromJson(item);
    }).toList();
  }
}
