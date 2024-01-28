//This class contains method to seed data into the db on creation.

import 'package:sqflite/sqflite.dart';

import '../helpers/db_helper.dart';

import '../models/day_model.dart';
import '../models/mealtime_model.dart';

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
    //First need seedDaysTableData and seedMealTimeTableData to have run so that we can get that juicy data

    final dayTableData = await DBHelper.getData('day');
    dayTableData
        .map(
          (mapItem) => Day(
            dayId: mapItem['DayId'],
            dayName: mapItem['DayName'],
          ),
        )
        .toList();

    final mealTimeTableData = await DBHelper.getData('mealtime');
    mealTimeTableData
        .map(
          (mapItem) => MealTime(
            mealTimeId: mapItem['MealTimeId'],
            mealTimeName: mapItem['MealTimeName'],
          ),
        )
        .toList();

    for (var day in dayTableData) {
      for (var mealtime in mealTimeTableData) {
        final dayId = day['DayId'];
        final mealTimeId = mealtime['MealTimeId'];

        await db.insert('day_mealtime', {
          'DayId_FK': dayId,
          'MealTimeId_FK': mealTimeId,
        });
      }
    }
  }
}
