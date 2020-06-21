import 'ingredient.dart';

class Fridge {
  DateTime selectedDate = DateTime.now();
  List<Ingredient> ingredientList;

  int get totalIngredients =>  ingredientList.length;

  Fridge.empty();

  Fridge.fromJson(List<dynamic> jsonArray) {
    ingredientList = new List<Ingredient>();
    ingredientList = jsonArray.map((i)=>Ingredient.fromJson(i)).toList();
  }

  void clearSelection() {
    ingredientList.forEach((element) {element.isSelected=false;});
  }

  String selectedIngredients (){
    List<String> stringIngredientList = new List<String>();
    ingredientList.forEach((element) {
      if (element.isSelected) stringIngredientList.add(element.title);
    });
    return _getIngredientsString(stringIngredientList).trim();
  }

  String _getIngredientsString(List<String> stringIngredientList){
    String ingredientsString = stringIngredientList.toString();
    return ingredientsString.substring(1,ingredientsString.length-1).replaceAll(" ", "");
  }
}