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
    await db.execute('CREATE TABLE meal(MealId INTEGER PRIMARY KEY, MealName TEXT, IsDeleted INTEGER DEFAULT 0)');
    await db.execute('CREATE TABLE ingredient(IngredientId INTEGER PRIMARY KEY, IngredientName TEXT, IsDeleted INTEGER DEFAULT 0)');
    await db.execute('CREATE TABLE meal_ingredient(MealIngredientId INTEGER PRIMARY KEY, MealId_FK INTEGER, IngredientId_FK INTEGER, FOREIGN KEY (MealId_FK) REFERENCES meal(MealId), FOREIGN KEY (IngredientId_FK) REFERENCES ingredient(IngredientId))');
    await db.execute('CREATE TABLE shopping_list(ShoppingListItemId INTEGER PRIMARY KEY, MealId_FK INTEGER, IngredientId_FK INTEGER, IsMeal INTEGER, FOREIGN KEY (MealId_FK) REFERENCES meal(MealId), FOREIGN KEY (IngredientId_FK) REFERENCES ingredient(IngredientId))');

    //This is the main joining table that links meals/ingredients with the day_mealtime table and displays on the main Week screen
    await db.execute('CREATE TABLE mealtime_food(MealTimeFoodId INTEGER PRIMARY KEY, MealId_FK INTEGER, IngredientId_FK INTEGER, DayMealTimeId_FK, FOREIGN KEY (MealId_FK) REFERENCES meal(MealId), FOREIGN KEY (IngredientId_FK) REFERENCES ingredient(IngredientId), FOREIGN KEY (DayMealTimeId_FK) REFERENCES day_mealtime(DayMealTimeId))');

    //Adding Seed data 
    _seedDaysTableData();
  }
}

Future<void> _seedDaysTableData() async {
  final db = await DBHelper.database();
  await db.insert('day', {'DayName': 'Monday'});
  await db.insert('day', {'DayName': 'Tuesday'});
  await db.insert('day', {'DayName': 'Wednesday'});
  await db.insert('day', {'DayName': 'Thursday'});
  await db.insert('day', {'DayName': 'Friday'});
  await db.insert('day', {'DayName': 'Saturday'});
  await db.insert('day', {'DayName': 'Sunday'});
}