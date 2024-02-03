import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/db_helper.dart';

import '../models/ingredient_model.dart';

class IngredientNotifier extends StateNotifier<List<Ingredient>> {
  IngredientNotifier() : super([]);

  Future<void> fetchAndSetIngredients() async {
    final ingredientDataList =
        await DBHelper.getDataNotDeleted('ingredient', 'IsDeleted = 1');

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

final ingredientProvider =
    StateNotifierProvider<IngredientNotifier, List<Ingredient>>((ref) {
  return IngredientNotifier();
});
