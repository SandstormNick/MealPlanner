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
    await db.insert('meal', {'MealId': -1, 'MealName': 'None'});
  }

  static Future<void> seedIngredientTableData(Database db) async {
    await db.insert('ingredient', {'IngredientId': -1, 'IngredientName': 'None'});
  }
}
