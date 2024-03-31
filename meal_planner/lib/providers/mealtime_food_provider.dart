import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/db_helper.dart';

import '../models/mealtime_food_model.dart';
import '../models/meal_model.dart';
import '../models/ingredient_model.dart';

class MealTimeFoodNotifier extends StateNotifier<List<MealTimeFood>> {
  MealTimeFoodNotifier() : super([]);

  bool foodItemUpdated = false;

  Future<void> addFoodItem(
    int dayMealTimeId,
    int foodItemId,
    String foodItemName,
    bool isMeal,
  ) async {
    bool existingMapping = false;

    final mealtimeFoodData =
        await DBHelper.getDataRawQueryWithId('mealtimeFoodTableDataByDayMalTimeId', dayMealTimeId.toString());

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

    if (isMeal) {
      existingMapping = mealtimeFoodData.any((element) => element['MealId'] == foodItemId);
    } else {
      existingMapping = mealtimeFoodData.any((element) => element['IngredientId'] == foodItemId);
    }

    if (!existingMapping) {
      final mealtimeFoodItem = MealTimeFood(
        dayMealTimeId: dayMealTimeId,
        mealId: isMeal ? foodItemId : -1,
        mealName: isMeal ? foodItemName : '',
        ingredientId: !isMeal ? foodItemId : -1,
        ingredientName: !isMeal ? foodItemName : '',
      );

      final int insertedID = await DBHelper.insertReturnId('mealtime_food', {
        'MealId_FK': isMeal ? foodItemId : -1,
        'IngredientId_FK': !isMeal ? foodItemId : -1,
        'DayMealTimeId_FK': mealtimeFoodItem.dayMealTimeId,
        'IsDeleted': 0
      });

      mealtimeFoodItem.mealTimeFoodId = insertedID;

      state.add(mealtimeFoodItem);

    } else {
      Map<String, dynamic> filteredmealtimeFoodData;
      if (isMeal) {
        filteredmealtimeFoodData = mealtimeFoodData.firstWhere((element) => element['MealId'] == foodItemId);
      }
      else {
        filteredmealtimeFoodData = mealtimeFoodData.firstWhere((element) => element['IngredientId'] == foodItemId);
      }

      DBHelper.update(
        'mealtime_food',
        {
          'IsDeleted': 0,
        },
        'MealTimeFoodId = ?',
        filteredmealtimeFoodData['MealTimeFoodId']);

      foodItemUpdated = true;
    }

    state = [...state];
    fetchAndSetMealTimeFoods();
  }

  bool checkIfFoodItemExistsForMealTimeFood(
      bool isMeal, int foodItemID, int dayMealTimeID) {
    if (isMeal) {
      return state.any((mealtimeFood) =>
          mealtimeFood.mealId == foodItemID &&
          mealtimeFood.dayMealTimeId == dayMealTimeID);
    } else {
      return state.any((mealtimeFood) =>
          mealtimeFood.ingredientId == foodItemID &&
          mealtimeFood.dayMealTimeId == dayMealTimeID);
    }
  }

  Future<void> deleteFoodItem(MealTimeFood mealTimeFood) async {
    DBHelper.update(
        'mealtime_food',
        {
          'IsDeleted': 1,
        },
        'MealTimeFoodId = ?',
        mealTimeFood.mealTimeFoodId);

    state = [...state];

    foodItemUpdated = true;
  }

  Future<void> fetchAndSetMealTimeFoods() async {
    if (state.isEmpty || foodItemUpdated) {
      foodItemUpdated = false;

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

  Future<void> updateIngredientInMealTimeFood(Ingredient ingredient) async {
    for (var element in state) {
      if (element.ingredientId == ingredient.ingredientId) {
        element.ingredientName = ingredient.ingredientName;
      }
    }
  }

  Future<void> updateMealInMealTimeFood(Meal meal) async {
    for (var element in state) {
      if (element.mealId == meal.mealId) {
        element.mealName = meal.mealName;
      }
    }

    state = [...state];
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
