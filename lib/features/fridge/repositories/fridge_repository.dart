import 'package:tech_task/core/config/api_url.dart';
import 'package:tech_task/core/networking/api_provider.dart';

class FridgeRepository{
  final ApiProvider apiProvider;

  FridgeRepository({this.apiProvider})
      : assert(apiProvider != null);

  Future<List<dynamic>> getIngredientList() async {
    return await apiProvider.get(ApiUrl.ingredientListUrl);
  }
}