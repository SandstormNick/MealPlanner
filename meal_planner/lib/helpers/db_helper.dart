import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

import '/helpers/seed_helper.dart';
import '/helpers/raw_sql_query_helper.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'mealplanner.db'),
        onCreate: (db, version) => _createDb(db), version: 1);
  }

  static void _createDb(Database db) async {
    await db
        .execute('CREATE TABLE day(DayId INTEGER PRIMARY KEY, DayName TEXT)');
    await db.execute(
        'CREATE TABLE mealtime(MealTimeId INTEGER PRIMARY KEY, MealTimeName TEXT)');
    await db.execute(
        'CREATE TABLE day_mealtime(DayMealTimeId INTEGER PRIMARY KEY, DayId_FK INTEGER, MealTimeId_FK INTEGER, FOREIGN KEY (DayId_FK) REFERENCES day(DayId), FOREIGN KEY (MealTimeId_FK) REFERENCES mealtime(MealTimeId))');
    await db.execute(
        'CREATE TABLE meal(MealId INTEGER PRIMARY KEY, MealName TEXT, IsDeleted INTEGER DEFAULT 0)');
    await db.execute(
        'CREATE TABLE ingredient(IngredientId INTEGER PRIMARY KEY, IngredientName TEXT, IsDeleted INTEGER DEFAULT 0)');
    await db.execute(
        'CREATE TABLE meal_ingredient(MealIngredientId INTEGER PRIMARY KEY, MealId_FK INTEGER, IngredientId_FK INTEGER, FOREIGN KEY (MealId_FK) REFERENCES meal(MealId), FOREIGN KEY (IngredientId_FK) REFERENCES ingredient(IngredientId))');
    await db.execute(
        'CREATE TABLE shopping_list(ShoppingListItemId INTEGER PRIMARY KEY, MealId_FK INTEGER, IngredientId_FK INTEGER, IsMeal INTEGER, FOREIGN KEY (MealId_FK) REFERENCES meal(MealId), FOREIGN KEY (IngredientId_FK) REFERENCES ingredient(IngredientId))'); //Pretty sure I can remove the IsMeal column

    //This is the main joining table that links meals/ingredients with the day_mealtime table and displays on the main Week screen
    await db.execute(
        'CREATE TABLE mealtime_food(MealTimeFoodId INTEGER PRIMARY KEY, MealId_FK INTEGER, IngredientId_FK INTEGER, DayMealTimeId_FK, IsDeleted INTEGER DEFAULT 0, FOREIGN KEY (MealId_FK) REFERENCES meal(MealId), FOREIGN KEY (IngredientId_FK) REFERENCES ingredient(IngredientId), FOREIGN KEY (DayMealTimeId_FK) REFERENCES day_mealtime(DayMealTimeId))');

    //Adding Seed data
    await SeedData.seedDaysTableData(db);
    await SeedData.seedMealTimeTableData(db);
    await SeedData.seedDayMealTimeTableData(db);
    await SeedData.seedMealTableData(db);
    await SeedData.seedIngredientTableData(db);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getDataWhereClause(
      String table, String whereClause) async {
    final db = await DBHelper.database();

    return db.query(
      table,
      where: whereClause,
    );
  }

  static Future<List<Map<String, dynamic>>> getDataRawQuery(
      String queryName) async {
    final db = await DBHelper.database();
    return db.rawQuery(RawSQLQueryHelper.getSQLQueryString(queryName));
  }

  static Future<List<Map<String, dynamic>>> getDataRawQueryWithId(
      String queryName, String whereClause) async {
    final db = await DBHelper.database();
    String sqlQuery = queryName + whereClause;
    return db.rawQuery(sqlQuery);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<int> insertReturnId(
      String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    final int insertedId = await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return insertedId;
  }

  static Future<void> update(
    String table,
    Map<String, Object> data,
    String whereClause,
    int? filterId,
  ) async {
    final db = await DBHelper.database();
    db.update(table, data, where: whereClause, whereArgs: [filterId]);
  }
}
