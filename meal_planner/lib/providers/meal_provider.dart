import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/helpers/db_helper.dart';

import '../models/meal_model.dart'; //should be able to remove

class MealNotifier extends StateNotifier<List<Meal>> {
  MealNotifier() : super([]);

  Future<void> fetchAndSetMeals() async {

    if (state.isEmpty) {
      final mealsDataList =
          await DBHelper.getDataNotDeleted('meal', 'IsDeleted = 0 AND MealName != "None"');

      List<Map<String, dynamic>> mealsList = List.from(mealsDataList);
      mealsList.sort((a, b) => a['MealName'].compareTo(b['MealName']));

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

  List<Meal> getAllMeals() {
    return state;
  }

  void printItemsDebugMethod() async {
    final mealsDataList =
        await DBHelper.getDataNotDeleted('meal', 'IsDeleted = 0');

    List<Map<String, dynamic>> mealsList = List.from(mealsDataList);

    mealsList.sort((a, b) => a['MealName'].compareTo(b['MealName']));

    mealsList
        .map(
          (mapItem) => Meal(
            mealId: mapItem['MealId'],
            mealName: mapItem['MealName'],
          ),
        )
        .toList();

    for (var meal in mealsList) {
      final mealId = meal['MealId'];
      final mealName = meal['MealName'];

      print("MealId: $mealId");
      print("MealName: $mealName");
      print("------------");
    }
  }
}

final mealProvider = StateNotifierProvider<MealNotifier, List<Meal>>((ref) {
  return MealNotifier();
});
