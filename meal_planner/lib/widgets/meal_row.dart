import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './week_widgets/add_food_to_mealtime_form.dart';
import './mealtime_food_card.dart';

import '../models/mealtime_food_model.dart';

import '../providers/mealtime_food_provider.dart';

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
    List<MealTimeFood> mealtimeFoodItems = ref
        .watch(mealtimeFoodProvider.notifier)
        .getMealTimeFoodForDayMealTime(dayMealTimeId);

    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(mealTimeName),
        ),
        const SizedBox(width: 8), //maybe change this at some point
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AddFoodToMealTimeForm(dayMealTimeId: dayMealTimeId);
              },
            );
          },
          icon: const Icon(Icons.add),
        ),
        const SizedBox(width: 8), //maybe change this at some point
        Expanded(
            child: SizedBox(
          height: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var mealTimeFood in mealtimeFoodItems)
                  MealTimeFoodCard(
                    mealTimeFood: mealTimeFood,
                  ),
              ],
            ),
          ),
        ))
      ],
    );
  }
}
