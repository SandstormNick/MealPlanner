import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mealtime_food_model.dart';

class MealTimeFoodCard extends ConsumerWidget {
  final MealTimeFood mealTimeFood;

  MealTimeFoodCard({
    Key? key,
    required this.mealTimeFood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(mealTimeFood.mealName),
      ),
    );
  }
}
