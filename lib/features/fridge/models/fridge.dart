import 'ingredient.dart';

class Fridge {
  bool isLoading;
  DateTime selectedDate;
  List<Ingredient> ingredientList;

  int get totalIngredients =>  ingredientList.length;

  Fridge.fromJson(List<dynamic> jsonArray) {
    ingredientList = new List<Ingredient>();
    ingredientList = jsonArray.map((i)=>Ingredient.fromJson(i)).toList();
  }
}