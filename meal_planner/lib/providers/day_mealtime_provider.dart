import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/db_helper.dart';

import '../models/day_model.dart';  //should be able to remove
import '../models/mealtime_model.dart';  //should be able to remove
import '../models/day_mealtime_model.dart';

class DayMealTimeNotifier extends StateNotifier<List<DayMealTime>> {
  DayMealTimeNotifier(): super([]);

  //method to fetch - don't need the ability to add or update DayMealTime

  Future<void> fetchAndSetDayMealTimes() async {
    //final dataList = DBHelper.getData('')
    //final dayTableData = await DBHelper
    final dataList = await DBHelper.getDataRawQuery('dayMealtimeTableData');
    state = dataList.map(
          (mapItem) => DayMealTime(
            dayMealTimeId: mapItem['DayMealTimeId'],
            dayId: mapItem['DayId'],
            dayName: mapItem['DayName'],
            mealTimeId: mapItem['MealTimeId'],
            mealTimeName: mapItem['MealTimeName']
          ),
        )
        .toList();
  }


  //But use it to try print the Day and MealTime and DayMealTime table records
  //Remove this/ comment it out at some point
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

    final daymealTimeTableData = await DBHelper.getDataRawQuery('dayMealtimeTableData');
    daymealTimeTableData
        .map(
          (mapItem) => DayMealTime(
            dayMealTimeId: mapItem['DayMealTimeId'],
            dayId: mapItem['DayId'],
            dayName: mapItem['DayName'],
            mealTimeId: mapItem['MealTimeId'],
            mealTimeName: mapItem['MealTimeName']
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

    for (var dayMealTime in daymealTimeTableData) {
      final daymealtimeId = dayMealTime['DayMealTimeId'];
      final dayIdFK = dayMealTime['DayId'];
      final dayName = dayMealTime['DayName'];
      final mealtimeIdFk = dayMealTime['MealTimeId'];
      final mealtimeName = dayMealTime['MealTimeName'];

      print("Day_MealTime: $daymealtimeId. Day: $dayIdFK - $dayName. MealTime: $mealtimeIdFk - $mealtimeName");
    }
  }

  // TextButton(
  //   onPressed: () {
  //     ref.watch(dayMealTimeProvider.notifier).printItemsDebugMethod();
  //   },
  //   child: const Text('Print Items'),
  // ),


}

final dayMealTimeProvider = StateNotifierProvider<DayMealTimeNotifier, List<DayMealTime>>((ref) {
  return DayMealTimeNotifier();
});