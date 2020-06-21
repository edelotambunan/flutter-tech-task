import 'package:tech_task/core/config/api_url.dart';
import 'package:tech_task/core/networking/api_provider.dart';

class RecipeRepository{
  final ApiProvider apiProvider;

  RecipeRepository({this.apiProvider})
      : assert(apiProvider != null);

  Future<List<dynamic>> getRecipeList(String selectedIngredients) async {
    return await apiProvider.get(ApiUrl.recipeListUrl + selectedIngredients);
  }
}