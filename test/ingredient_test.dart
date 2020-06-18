import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/features/fridge/models/ingredient.dart';

void main() {

  group('Ingredient', (){
    test('with invalid date format should be considered outdated (true)', () {
      Map<String, dynamic> mockIngredientJson = {'title': 'Ingredient with invalid date format', 'use-by': '2020-06.18'};
      final mockIngredient = Ingredient.fromJson(mockIngredientJson);
      final mockCurrentDate = DateTime.now();
      final isPastUseBy = mockIngredient.isPastUseBy(mockCurrentDate);

      expect(isPastUseBy, true);
    });

    test('with use-by date before current date should return true', () {
      Map<String, dynamic> mockIngredientJson = {'title': 'Ingredient with outdated use-by date', 'use-by': '2000-06-18'};
      final mockIngredient = Ingredient.fromJson(mockIngredientJson);
      final mockDateAfterUseBy = new DateTime(2020, 06, 18);
      final isPastUseBy = mockIngredient.isPastUseBy(mockDateAfterUseBy);

      expect(isPastUseBy, true);
    });

    test('with use-by date after current date should return false', () {
      Map<String, dynamic> mockIngredientJson = {'title': 'Ingredient with use-by date after current Date', 'use-by': '2020-06-18'};
      final mockIngredient = Ingredient.fromJson(mockIngredientJson);
      final mockDateBeforeUseBy = new DateTime(2000, 06, 18);
      final isPastUseBy = mockIngredient.isPastUseBy(mockDateBeforeUseBy);

      expect(isPastUseBy, false);
    });
  });
}
