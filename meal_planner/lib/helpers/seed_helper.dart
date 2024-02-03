//This class contains method to seed data into the db on creation.

import 'package:sqflite/sqflite.dart';

class SeedData {
  static Future<void> seedDaysTableData(Database db) async {
    await db.insert('day', {'DayName': 'Monday'});
    await db.insert('day', {'DayName': 'Tuesday'});
    await db.insert('day', {'DayName': 'Wednesday'});
    await db.insert('day', {'DayName': 'Thursday'});
    await db.insert('day', {'DayName': 'Friday'});
    await db.insert('day', {'DayName': 'Saturday'});
    await db.insert('day', {'DayName': 'Sunday'});
  }

  static Future<void> seedMealTimeTableData(Database db) async {
    await db.insert('mealtime', {'MealTimeName': 'Breakfast'});
    await db.insert('mealtime', {'MealTimeName': 'Lunch'});
    await db.insert('mealtime', {'MealTimeName': 'Dinner'});
  }

  static Future<void> seedDayMealTimeTableData(Database db) async {
    await db.insert('day_mealtime', {'DayId_FK': 1, 'MealTimeId_FK': 1});
    await db.insert('day_mealtime', {'DayId_FK': 1, 'MealTimeId_FK': 2});
    await db.insert('day_mealtime', {'DayId_FK': 1, 'MealTimeId_FK': 3});

    await db.insert('day_mealtime', {'DayId_FK': 2, 'MealTimeId_FK': 1});
    await db.insert('day_mealtime', {'DayId_FK': 2, 'MealTimeId_FK': 2});
    await db.insert('day_mealtime', {'DayId_FK': 2, 'MealTimeId_FK': 3});

    await db.insert('day_mealtime', {'DayId_FK': 3, 'MealTimeId_FK': 1});
    await db.insert('day_mealtime', {'DayId_FK': 3, 'MealTimeId_FK': 2});
    await db.insert('day_mealtime', {'DayId_FK': 3, 'MealTimeId_FK': 3});

    await db.insert('day_mealtime', {'DayId_FK': 4, 'MealTimeId_FK': 1});
    await db.insert('day_mealtime', {'DayId_FK': 4, 'MealTimeId_FK': 2});
    await db.insert('day_mealtime', {'DayId_FK': 4, 'MealTimeId_FK': 3});

    await db.insert('day_mealtime', {'DayId_FK': 5, 'MealTimeId_FK': 1});
    await db.insert('day_mealtime', {'DayId_FK': 5, 'MealTimeId_FK': 2});
    await db.insert('day_mealtime', {'DayId_FK': 5, 'MealTimeId_FK': 3});

    await db.insert('day_mealtime', {'DayId_FK': 6, 'MealTimeId_FK': 1});
    await db.insert('day_mealtime', {'DayId_FK': 6, 'MealTimeId_FK': 2});
    await db.insert('day_mealtime', {'DayId_FK': 6, 'MealTimeId_FK': 3});

    await db.insert('day_mealtime', {'DayId_FK': 7, 'MealTimeId_FK': 1});
    await db.insert('day_mealtime', {'DayId_FK': 7, 'MealTimeId_FK': 2});
    await db.insert('day_mealtime', {'DayId_FK': 7, 'MealTimeId_FK': 3});
  }

  static Future<void> seedMealTableData(Database db) async {
    await db.insert('meal', {'MealName': 'Chicken stir fry'});
    await db.insert('meal', {'MealName': 'Beef stir fry'});
    await db.insert('meal', {'MealName': 'Chicken salad'});
    await db.insert('meal', {'MealName': 'Tuna salad'});
    await db.insert('meal', {'MealName': 'Yoghurt @ work'});
  }

  static Future<void> seedIngredientTableData(Database db) async {
    await db.insert('ingredient', {'IngredientName': 'Apples'});
    await db.insert('ingredient', {'IngredientName': 'Tuna'});
    await db.insert('ingredient', {'IngredientName': 'Chicken'});
    await db.insert('ingredient', {'IngredientName': 'Stir fry veg'});
    await db.insert('ingredient', {'IngredientName': 'Eggs'});
    await db.insert('ingredient', {'IngredientName': 'Pasta'});
    await db.insert('ingredient', {'IngredientName': 'Pasta sauce'});
    await db.insert('ingredient', {'IngredientName': 'Butter chicken sauce'});
    await db.insert('ingredient', {'IngredientName': 'Cheese'});
    await db.insert('ingredient', {'IngredientName': 'Provitas'});
    await db.insert('ingredient', {'IngredientName': 'Avos'});
    await db.insert('ingredient', {'IngredientName': 'Milk'});
    await db.insert('ingredient', {'IngredientName': 'Steak'});
    await db.insert('ingredient', {'IngredientName': 'Real soup'});
    await db.insert('ingredient', {'IngredientName': 'Frozen Veg'});
  }
}
