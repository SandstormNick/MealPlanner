//import 'package:meal_planner/providers/day_mealtime_provider.dart';

class RawSQLQueryHelper{

  //Add Raw SQL Quesry strings here that can be retrieved using the switch statement
  static const String dayMealtimeTableData = 'SELECT dmt.DayMealTimeId, d.DayId, d.DayName, mt.MealTimeId, mt.MealTimeName FROM day_mealtime dmt JOIN day d ON dmt.DayId_FK = d.DayId JOIN mealtime mt ON dmt.MealTimeId_FK = mt.MealTimeId';

  static String getSQLQueryString(String queryName) {
    switch(queryName){
      case 'dayMealtimeTableData':
        return dayMealtimeTableData;
      default:
        return '';
    }
  }
}