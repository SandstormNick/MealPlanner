import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/day_mealtime_model.dart';

import './meal_row.dart';

// ignore: must_be_immutable
class DayCard extends ConsumerWidget {
  final List<DayMealTime> dayMealTimeList;
  String dayName = '';
  String breakfast = '';
  String lunch = '';
  String dinner = '';

  DayCard({
    Key? key,
    required this.dayMealTimeList,
  }) : super(key: key) {
    dayName = dayMealTimeList[0].dayName;

    //This should be assigned in the for loop so we can check the id of the mealtime - and that way you can be assured what the dayMealTimeId is
    breakfast = dayMealTimeList[0].mealTimeName;
    lunch = dayMealTimeList[1].mealTimeName;
    dinner = dayMealTimeList[2].mealTimeName;

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
            Text(dayName),
            Text(breakfast),
            Text(lunch),
            Text(dinner),
            MealRow(),
            //RowItem("Row 2 Content"),
            //RowItem("Row 3 Content"),
            //RowItem("Row 4 Content"),
          ],
        ),
      ),
    );
  }
}

//Change this name to MealRow
class RowItem extends StatelessWidget {
  final String content;

  RowItem(this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.star),
          SizedBox(width: 8),
          Text(content),
        ],
      ),
    );
  }
}
