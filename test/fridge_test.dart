import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/features/fridge/models/fridge.dart';
import 'package:tech_task/features/fridge/models/ingredient.dart';

void main() {

  group('Fridge', (){
    Map<String, dynamic> mockIngredientJson1 = {'title': 'Ham', 'use-by': '2000-06-18'};
    Map<String, dynamic> mockIngredientJson2 = {'title': 'Bun', 'use-by': '2000-06-18'};
    final mockIngredient1 = Ingredient.fromJson(mockIngredientJson1);
    final mockIngredient2 = Ingredient.fromJson(mockIngredientJson2);
    final mockFridge = Fridge.empty();
    mockFridge.ingredientList = new List<Ingredient>();
    mockFridge.ingredientList.add(mockIngredient1);
    mockFridge.ingredientList.add(mockIngredient2);

    test(' Ingredients isSelected should return false after clearSelection', () {
      mockFridge.ingredientList[0].isSelected = true;
      mockFridge.clearSelection();

      expect(mockFridge.ingredientList[0].isSelected, false);
    });

    test(' Ingredients selectedIngredients should be empty after clearSelection', () {
      mockFridge.ingredientList[0].isSelected = true;
      mockFridge.clearSelection();

      expect(mockFridge.selectedIngredients(), isEmpty);
    });

    test(' Ingredients selectedIngredients should return all selected ingredients separated by comma', () {
      mockFridge.ingredientList[0].isSelected = true;
      mockFridge.ingredientList[1].isSelected = true;

      expect(mockFridge.selectedIngredients(), "Ham,Bun");
    });
  });
}
