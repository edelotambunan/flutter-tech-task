class ApiUrl{
  static const String baseUrl = 'https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev';
//  static const String baseUrl = 'http://localhost:8081';
  static const String ingredientListUrl = baseUrl + "/ingredients";
  static const String recipeListUrl = baseUrl + "/recipes?ingredients=";
}