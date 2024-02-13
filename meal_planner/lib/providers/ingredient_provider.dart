import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/db_helper.dart';

import '../models/ingredient_model.dart';

class IngredientNotifier extends StateNotifier<List<Ingredient>> {
  IngredientNotifier() : super([]);

  Future<void> fetchAndSetIngredients() async {
    if (state.isEmpty) {
      final ingredientDataList =
        await DBHelper.getDataNotDeleted('ingredient', 'IsDeleted = 0');

      List<Map<String, dynamic>> ingredientsList = List.from(ingredientDataList);
      ingredientsList
          .sort((a, b) => a['IngredientName'].compareTo(b['IngredientName']));

      state = ingredientsList
          .map(
            (mapItem) => Ingredient(
              ingredientId: mapItem['IngredientId'],
              ingredientName: mapItem['IngredientName'],
            ),
          )
          .toList();
      }
    }

    List<Ingredient> getAllIngredients() {
      return state;
  }

}

final ingredientProvider =
    StateNotifierProvider<IngredientNotifier, List<Ingredient>>((ref) {
  return IngredientNotifier();
});
