import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealRow extends ConsumerWidget {
  final int dayMealTimeId;
  final String mealTimeName;

  MealRow({
    Key? key,
    required this.dayMealTimeId,
    required this.mealTimeName,
  }) : super(key: key) {
    // print(dayMealTimeId);
    // print(mealTimeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          width: 70,
          child: Text(mealTimeName),
        ),
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
              ],
            ),
          ),
        ))
      ],
    );
  }
}
