import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/db_helper.dart';

import '../models/mealtime_food_model.dart';

class MealTimeFoodNotifier extends StateNotifier<List<MealTimeFood>> {
  MealTimeFoodNotifier() : super([]);

  Future<void> addFoodItem(int dayMealTimeId, int foodItemId, bool isMeal) async {
    final mealtimeFoodItem = MealTimeFood(
      dayMealTimeId: dayMealTimeId,
      mealId: isMeal ? foodItemId : null,
      ingredientId: !isMeal ? foodItemId : null,
    );

    await DBHelper.insert('mealtime_food', {
      'MealId_FK': isMeal ? foodItemId : Null,
      'IngredientId_FK' : !isMeal ? foodItemId : Null,
      'DayMealTimeId_FK': mealtimeFoodItem.dayMealTimeId,
      'IsDeleted': 0
    });

    state.add(mealtimeFoodItem);
    state = [...state];
  }
}

final mealtimeFoodProvider =
    StateNotifierProvider<MealTimeFoodNotifier, List<MealTimeFood>>((ref) {
  return MealTimeFoodNotifier();
});
