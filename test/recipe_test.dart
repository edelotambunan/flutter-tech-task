import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/features/recipes/models/recipe.dart';

void main() {

  group('Recipe', (){
    Map<String, dynamic> mockRecipeJson = {'title': 'Burger', 'ingredients': new List<dynamic>()};
    final mockRecipe = Recipe.fromJson(mockRecipeJson);
    mockRecipe.ingredients.add("Ham");
    mockRecipe.ingredients.add("Cheese");

    test(' Ingredients getIngredientsString should return all ingredients separated by comma', () {
      expect(mockRecipe.getIngredientsString(), "Ham, Cheese");
    });
  });
}
