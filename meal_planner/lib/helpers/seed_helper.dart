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
}