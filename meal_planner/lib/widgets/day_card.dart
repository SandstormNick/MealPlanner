import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/day_mealtime_model.dart';

import './meal_row.dart';

// ignore: must_be_immutable
class DayCard extends ConsumerWidget {
  final List<DayMealTime> dayMealTimeList;
  late int dayMealTimeId;
  String dayName = '';
  String breakfast = '';
  String lunch = '';
  String dinner = '';

  DayCard({
    Key? key,
    required this.dayMealTimeList,
  }) : super(key: key) {
    dayName = dayMealTimeList[0].dayName;

    // print('I am a new Day Card widget');

    // for (var dayMealTimeObject in dayMealTimeList) {
    //   print('DayMealTimeId: ${dayMealTimeObject.dayMealTimeId}');
    //   print('DayId: ${dayMealTimeObject.dayId}');
    //   print('DayName: ${dayMealTimeObject.dayName}');
    // }

    // print('---------------------------');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var dayMealTime in dayMealTimeList)
              MealRow(
                dayMealTimeId: dayMealTime.dayMealTimeId,
                mealTimeName: dayMealTime.mealTimeName,
              ),
          ],
        ),
      ),
    );
  }
}
