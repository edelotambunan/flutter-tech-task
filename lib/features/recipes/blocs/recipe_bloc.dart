import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:tech_task/core/networking/api_provider.dart';
import 'package:tech_task/core/networking/api_response.dart';
import 'package:tech_task/features/recipes/models/recipe.dart';
import 'package:tech_task/features/recipes/repositories/recipe_repository.dart';

class RecipeBloc{
  RecipeRepository _recipeRepository;
  StreamController _recipeController;
  String _selectedIngredients;

  StreamSink<ApiResponse<List<Recipe>>> get recipeSink =>
      _recipeController.sink;

  Stream<ApiResponse<List<Recipe>>> get recipeStream =>
      _recipeController.stream;

  RecipeBloc(String selectedIngredients) {
    _recipeController = StreamController<ApiResponse<List<Recipe>>>();
    _recipeRepository = RecipeRepository(apiProvider: ApiProvider(httpClient: http.Client()));
    _selectedIngredients = selectedIngredients;
    getRecipe();
  }

  getRecipe() async {
    recipeSink.add(ApiResponse.loading('Fetching Ingredients...'));
    try {
      List<dynamic> results = await _recipeRepository.getRecipeList(_selectedIngredients);
      List<Recipe> recipeList = new List<Recipe>();
      results.forEach((element) {recipeList.add(Recipe.fromJson(element));});
      recipeSink.add(ApiResponse.completed(recipeList));
    } catch (e) {
      recipeSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _recipeController?.close();
  }
}