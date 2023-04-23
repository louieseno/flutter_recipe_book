class EdamamRecipe {
  String id;
  String label;
  String image;
  String dishType;
  List<String> ingredients;
  String? createdAt;
  String? modifiedAt;

  EdamamRecipe(
      {required this.id,
      required this.label,
      required this.image,
      required this.dishType,
      required this.ingredients,
      this.createdAt,
      this.modifiedAt});

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "image": image,
        "dishType": dishType,
        "ingredients": ingredients,
        "createdAt": createdAt ?? DateTime.now().toIso8601String(),
        "modifiedAt": modifiedAt ?? DateTime.now().toIso8601String(),
      };

  factory EdamamRecipe.fromEdamamJson(Map<String, dynamic> json) {
    return EdamamRecipe(
        id: json['uri'].split('#')[1],
        label: json['label'],
        image: json['image'],
        dishType: json['dishType'][0],
        ingredients: List<String>.from(json['ingredientLines']),
        createdAt: json['createdAt'],
        modifiedAt: json['modifiedAt']);
  }

  factory EdamamRecipe.fromJsonServer(Map<String, dynamic> json) {
    return EdamamRecipe(
        id: json['id'],
        label: json['label'],
        image: json['image'],
        dishType: json['dishType'],
        ingredients: List<String>.from(json['ingredients']),
        createdAt: json['createdAt'],
        modifiedAt: json['modifiedAt']);
  }

  static List<EdamamRecipe> recipesFromEdamam(List snapshot) {
    return snapshot.map((item) {
      return EdamamRecipe.fromEdamamJson(item);
    }).toList();
  }

  static List<EdamamRecipe> recipesFromJsonServer(List snapshot) {
    return snapshot.map((item) {
      return EdamamRecipe.fromJsonServer(item);
    }).toList();
  }

  static List<Map<String, dynamic>> objectFromRecipes(
      List<EdamamRecipe> recipe) {
    return recipe.map((item) {
      return item.toJson();
    }).toList();
  }
}
