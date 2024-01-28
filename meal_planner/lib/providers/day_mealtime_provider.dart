import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/db_helper.dart';

import '../models/day_model.dart';  //should be able to remove
import '../models/mealtime_model.dart';  //should be able to remove
import '../models/day_mealtime_model.dart';  //should be able to remove

class DayMealTimeNotifier extends StateNotifier<List<DayMealTime>> {
  DayMealTimeNotifier(): super([]);

  //method to fetch - don't need the ability to add or update DayMealTime

  Future<void> fetchAndSetDayMealTimes() async {
    //final dataList = DBHelper.getData('')
  }

  //Somma delete this when you're done 
  //But use it to try print the Day and MealTime and DayMealTime table records
  void printItemsDebugMethod() async {
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

    final day_mealTimeTableData = await DBHelper.getData('day_mealtime');
    day_mealTimeTableData
        .map(
          (mapItem) => DayMealTime(
            dayMealTimeId: mapItem['DayMealTimeId'],
            dayId: mapItem['DayId_FK'],
            dayName: '-',
            mealTimeId: mapItem['MealTimeId_FK'],
            mealTimeName: ''
          ),
        )
        .toList();

    //print _items -uncomment the print to utilize
    //print('Printing records from item Table');
    for (var mealtime in mealTimeTableData) {
      final mealId = mealtime['MealTimeId'];
      final mealName = mealtime['MealTimeName'];

      print("Mealtime: $mealId - $mealName");
    }

    print('--------------------');

    for (var day in dayTableData) {
      final dayId = day['DayId'];
      final dayName = day['DayName'];

      print("Day: $dayId - $dayName");
    }

    print('--------------------');

    for (var dayMealTime in day_mealTimeTableData) {
      final daymealtimeId = dayMealTime['DayMealTimeId'];
      final dayIdFK = dayMealTime['DayId_FK'];
      final mealtimeIdFk = dayMealTime['MealTimeId_FK'];

      print("Day_MealTime: $daymealtimeId. DayId(FK): $dayIdFK. MealTimeId(FK): $mealtimeIdFk");
    }
  }


}

final dayMealTimeProvider = StateNotifierProvider<DayMealTimeNotifier, List<DayMealTime>>((ref) {
  return DayMealTimeNotifier();
});