import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealRow extends ConsumerWidget {
  //Will need to pass in the following: 
  //This will need the mealtime
  //The DayMealTimeId

  MealRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Text('The meal'),
        SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
        ),
        SizedBox(width: 8),
        const Expanded(
            child: SizedBox(
          height: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  'Meal 1',
                ),
                Text(
                  'Meal 2',
                ),
                Text(
                  'Meal 3',
                ),
                Text(
                  'Meal 4',
                ),
                Text(
                  'Meal 5',
                ),
                Text(
                  'Meal 6',
                ),
                Text(
                  'Meal 7',
                ),
                Text(
                  'Meal 8',
                ),
                Text(
                  'Meal 9',
                ),
              ],
            ),
          ),
        ))
      ],
    );
  }
}
