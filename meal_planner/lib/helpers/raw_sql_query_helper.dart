//import 'package:meal_planner/providers/day_mealtime_provider.dart';

class RawSQLQueryHelper{

  //Add Raw SQL Quesry strings here that can be retrieved using the switch statement
  static const String dayMealtimeTableData = 'SELECT dmt.DayMealTimeId, d.DayId, d.DayName, mt.MealTimeId, mt.MealTimeName FROM day_mealtime dmt JOIN day d ON dmt.DayId_FK = d.DayId JOIN mealtime mt ON dmt.MealTimeId_FK = mt.MealTimeId';

  static const String dayMealtimeTableDataById = 'SELECT dmt.DayMealTimeId, d.DayId, d.DayName, mt.MealTimeId, mt.MealTimeName FROM day_mealtime dmt JOIN day d ON dmt.DayId_FK = d.DayId JOIN mealtime mt ON dmt.MealTimeId_FK = mt.MealTimeId WHERE dmt.DayMealTimeId = ';

  static const String mealtimeFoodTableData = 'SELECT mtf.MealTimeFoodId, mtf.DayMealTimeId_FK, mtf.IsDeleted, m.MealId, m.MealName, i.IngredientId, i.IngredientName FROM mealtime_food mtf JOIN meal m ON mtf.MealId_FK = m.MealId JOIN ingredient i ON mtf.IngredientId_FK = i.IngredientId WHERE mtf.IsDeleted != 1';

  static const String mealtimeFoodTableDataByDayMalTimeId = 'SELECT mtf.MealTimeFoodId, mtf.DayMealTimeId_FK, mtf.IsDeleted, m.MealId, m.MealName, i.IngredientId, i.IngredientName FROM mealtime_food mtf JOIN meal m ON mtf.MealId_FK = m.MealId JOIN ingredient i ON mtf.IngredientId_FK = i.IngredientId WHERE mtf.DayMealTimeId_FK = ';

  static String getSQLQueryString(String queryName) {
    switch(queryName){
      case 'dayMealtimeTableData':
        return dayMealtimeTableData;
      case 'mealtimeFoodTableData':
        return mealtimeFoodTableData;
      case 'mealtimeFoodTableDataByDayMalTimeId':
        return mealtimeFoodTableDataByDayMalTimeId;
      default:
        return '';
    }
  }
}