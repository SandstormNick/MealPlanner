import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mealtime_food_model.dart';

class MealTimeFoodCard extends ConsumerWidget {
  final MealTimeFood mealTimeFood;

  const MealTimeFoodCard({
    Key? key,
    required this.mealTimeFood,
  }) : super(key: key);

  String getMealTimeFoodName() {
    if (mealTimeFood.mealId != -1) {
      return mealTimeFood.mealName;
    } else {
      return mealTimeFood.ingredientName;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(getMealTimeFoodName()),
      ),
    );
  }
}
