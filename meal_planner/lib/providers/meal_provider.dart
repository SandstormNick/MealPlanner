import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/helpers/db_helper.dart';

import '../models/meal_model.dart';

class MealNotifier extends StateNotifier<List<Meal>> {
  MealNotifier() : super([]);

  Future<void> addMeal(String mealName) async {
    final newMeal = Meal(mealName: mealName);

    final int insertedId = await DBHelper.insertReturnId('meal', {
      'MealName': newMeal.mealName,
      'IsDeleted': 0,
    });

    newMeal.mealId = insertedId;

    state.add(newMeal);
    state.sort((a, b) => a.mealName.compareTo(b.mealName));
    state = [...state];
  }

  bool checkIfMealExists(String newMealName) {
    return state.any((meal) => meal.mealName.toLowerCase() == newMealName.toLowerCase());
  }

  Future<void> fetchAndSetMeals() async {
    if (state.isEmpty) {
      final mealsDataList = await DBHelper.getDataNotDeleted(
          'meal', 'IsDeleted = 0 AND MealName != "None"');

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

  Future<void> updateMeal(Meal meal) async {
    DBHelper.update(
      'meal',
      {
        'MealName': meal.mealName,
      },
      'MealId = ?',
      meal.mealId,
    );
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
