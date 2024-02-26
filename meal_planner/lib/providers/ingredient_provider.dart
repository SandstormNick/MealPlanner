import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/db_helper.dart';

import '../models/ingredient_model.dart';

class IngredientNotifier extends StateNotifier<List<Ingredient>> {
  IngredientNotifier() : super([]);

  Future<void> addIngredient(String ingredientName) async {
    final newIngredient = Ingredient(ingredientName: ingredientName);

    final int insertedId = await DBHelper.insertReturnId('ingredient', {
      'IngredientName': newIngredient.ingredientName,
      'IsDeleted': 0,
    });

    newIngredient.ingredientId = insertedId;

    state.add(newIngredient);
    state.sort((a, b) => a.ingredientName.compareTo(b.ingredientName));
    state = [...state];
  }

  bool checkIfIngredientExists(String newIngredientName) {
    return state.any((ingredient) => ingredient.ingredientName.toLowerCase() == newIngredientName.toLowerCase());
  }

  Future<void> fetchAndSetIngredients() async {
    if (state.isEmpty) {
      final ingredientDataList = await DBHelper.getDataNotDeleted(
          'ingredient', 'IsDeleted = 0 AND IngredientName != "None"');

      List<Map<String, dynamic>> ingredientsList =
          List.from(ingredientDataList);
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

  Future<void> updateIngredient(Ingredient ingredient) async {
    DBHelper.update(
      'ingredient',
      {'IngredientName': ingredient.ingredientName},
      'IngredientId = ?',
      ingredient.ingredientId,
    );
  }
}

final ingredientProvider =
    StateNotifierProvider<IngredientNotifier, List<Ingredient>>((ref) {
  return IngredientNotifier();
});
