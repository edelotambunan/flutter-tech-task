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
}