class Recipe{
  String title;
  List<String> ingredients;

  Recipe({this.title, this.ingredients});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<dynamic> dynamicIngredientList = json['ingredients'];
    List<String> ingredients = dynamicIngredientList.map((i)=>i.toString()).toList();
    return Recipe(
        title: json['title'],
        ingredients: ingredients
    );
  }

  String getIngredientsString(){
    String ingredientsString = ingredients.toString();
    return ingredientsString.substring(1,ingredientsString.length-1).trim();
  }
}