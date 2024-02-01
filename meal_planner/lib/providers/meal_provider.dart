import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/helpers/db_helper.dart';

import '../models/meal_model.dart'; //should be able to remove

class MealNotifier extends StateNotifier<List<Meal>> {
  MealNotifier() : super([]);

  Future<void> fetchAndSetMeals() async {
    final mealsList =
        await DBHelper.getDataNotDeleted('meal', 'IsDeleted = 0');
    state = mealsList
        .map(
          (mapItem) => Meal(
            mealId: mapItem['MealId'],
            mealName: mapItem['MealName'],
          ),
        )
        .toList();
  }
}

final mealProvider = StateNotifierProvider<MealNotifier, List<Meal>>((ref) {
  return MealNotifier();
});
