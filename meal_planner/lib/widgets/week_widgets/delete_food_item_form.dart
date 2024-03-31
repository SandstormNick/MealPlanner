import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/day_mealtime_model.dart';
import '../../models/mealtime_food_model.dart';

import '../../providers/day_mealtime_provider.dart';
import 'package:meal_planner/providers/mealtime_food_provider.dart';

class DeleteFoodItemForm extends ConsumerStatefulWidget {
  final int dayMealTimeId;
  final MealTimeFood mealTimeFood;

  const DeleteFoodItemForm({
    Key? key,
    required this.dayMealTimeId,
    required this.mealTimeFood,
  }) : super(key: key);

  @override
  ConsumerState<DeleteFoodItemForm> createState() => _DeleteFoodItemFormState();
}

class _DeleteFoodItemFormState extends ConsumerState<DeleteFoodItemForm> {
  @override
  Widget build(BuildContext context) {
    String foodItemName = widget.mealTimeFood.mealId != -1
        ? widget.mealTimeFood.mealName
        : widget.mealTimeFood.ingredientName;

    DayMealTime dayMealTime = ref
        .watch(dayMealTimeProvider.notifier)
        .getDayMealTimeById(widget.dayMealTimeId);

    Future<void> deleteItem() async {
      widget.mealTimeFood.isDeleted = true;
      ref
          .watch(mealtimeFoodProvider.notifier)
          .deleteFoodItem(widget.mealTimeFood);
      ref.watch(mealtimeFoodProvider.notifier).fetchAndSetMealTimeFoods();

      if (mounted) {
        Navigator.pop(context);
      }
    }

    return Form(
        child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Remove '),
                TextSpan(
                  text: foodItemName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' from:'),
              ],
            ),
          ),
          Text('${dayMealTime.dayName} - ${dayMealTime.mealTimeName}'),
          const Divider(
            color: Colors.black,
            thickness: 1.0,
          ),
          const Text(
              'You can also remove a food item by double clicking on it.'),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                deleteItem();
              },
              child: const Text('REMOVE'),
            ),
          )
        ],
      ),
    ));
  }
}
