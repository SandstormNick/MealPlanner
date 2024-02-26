import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/db_helper.dart';

import '../models/mealtime_food_model.dart';

class MealTimeFoodNotifier extends StateNotifier<List<MealTimeFood>> {
  MealTimeFoodNotifier() : super([]);

  Future<void> addFoodItem(
    int dayMealTimeId,
    int foodItemId,
    String foodItemName,
    bool isMeal,
  ) async {
    final mealtimeFoodItem = MealTimeFood(
      dayMealTimeId: dayMealTimeId,
      mealId: isMeal ? foodItemId : -1,
      mealName: isMeal ? foodItemName : '',
      ingredientId: !isMeal ? foodItemId : -1,
      ingredientName: !isMeal ? foodItemName : '',
    );

    await DBHelper.insert('mealtime_food', {
      'MealId_FK': isMeal ? foodItemId : -1,
      'IngredientId_FK': !isMeal ? foodItemId : -1,
      'DayMealTimeId_FK': mealtimeFoodItem.dayMealTimeId,
      'IsDeleted': 0
    });

    state.add(mealtimeFoodItem);
    state = [...state];
  }

  Future<void> fetchAndSetMealTimeFoods() async {
    if (state.isEmpty) {
      final mealtimeFoodDataList =
          await DBHelper.getDataRawQuery('mealtimeFoodTableData');

      state = mealtimeFoodDataList
        .map(
          (mapItem) => MealTimeFood(
            mealTimeFoodId: mapItem['MealTimeFoodId'],
            dayMealTimeId: mapItem['DayMealTimeId_FK'],
            mealId: mapItem['MealId'],
            mealName: mapItem['MealName'],
            ingredientId: mapItem['IngredientId'],
            ingredientName: mapItem['IngredientName'],
            isDeleted: mapItem['IsDeleted'] == 0 ? false : true,
          ),
        )
        .toList();
    }
  }

  List<MealTimeFood> getMealTimeFoodForDayMealTime(int dayMealTimeId) {
    List<MealTimeFood> mealTimeFoods = state
        .where((mealTimeFood) => mealTimeFood.dayMealTimeId == dayMealTimeId)
        .toList();

    return mealTimeFoods;
  }

  //But use it to try print the mealtime_food table records
  //Remove this/ comment it out at some point
  void printItemsDebugMethod() async {
    // final List<Map<String, dynamic>> rawData =
    //     await DBHelper.getData('mealtime_food');

    final mealtimeFoodData =
        await DBHelper.getDataRawQuery('mealtimeFoodTableData');

    mealtimeFoodData
        .map(
          (mapItem) => MealTimeFood(
            mealTimeFoodId: mapItem['MealTimeFoodId'],
            dayMealTimeId: mapItem['DayMealTimeId_FK'],
            mealId: mapItem['MealId'],
            mealName: mapItem['MealName'],
            ingredientId: mapItem['IngredientId'],
            ingredientName: mapItem['IngredientName'],
            isDeleted: mapItem['IsDeleted'] == 0 ? false : true,
          ),
        )
        .toList();

    for (var mealTimeFood in mealtimeFoodData) {
      final mealTimeFoodId = mealTimeFood['MealTimeFoodId'];
      final dayMealTimeId = mealTimeFood['DayMealTimeId_FK'];

      final mealId = mealTimeFood['MealId'];
      final mealName = mealTimeFood['MealName'];

      final ingredientId = mealTimeFood['IngredientId'];
      final ingredientName = mealTimeFood['IngredientName'];

      print("MealTimeFoodId: $mealTimeFoodId");
      print("DayMealTimeId: $dayMealTimeId");
      print("Meal: $mealId - $mealName");
      print("Ingredient: $ingredientId - $ingredientName");
      print("----------------------------------");
    }
  }
}

final mealtimeFoodProvider =
    StateNotifierProvider<MealTimeFoodNotifier, List<MealTimeFood>>((ref) {
  return MealTimeFoodNotifier();
});
