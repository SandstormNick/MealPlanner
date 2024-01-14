import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'mealplanner.db'),
      onCreate: (db, version) => _createDb(db), version: 1
    );
  }

  static void _createDb(Database db) async {
    await db.execute('CREATE TABLE day(DayId INTEGER PRIMARY KEY, DayName TEXT)');
    await db.execute('CREATE TABLE mealtime(MealTimeId INTEGER PRIMARY KEY, MealTimeName TEXT)');
    await db.execute('CREATE TABLE day_mealtime(DayMealTimeId INTEGER PRIMARY KEY, DayId_FK INTEGER, MealTimeId_FK INTEGER, FOREIGN KEY (DayId_FK) REFERENCES day(DayId), FOREIGN KEY (MealTimeId_FK) REFERENCES mealtime(MealTimeId))');
    //DAY
      //DAY_MEALTIME
    //MEALTIME
        //MEALTIME_FOOD
    //MEAL
      //MEAL_INGREDIANT
    //INGREDIANT
    //SHOPPINGLIST
  }
}