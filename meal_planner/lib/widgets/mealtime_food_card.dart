import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/providers/mealtime_food_provider.dart';

import '../models/mealtime_food_model.dart';

class MealTimeFoodCard extends ConsumerStatefulWidget {
  final MealTimeFood mealTimeFood;

  const MealTimeFoodCard({
    Key? key,
    required this.mealTimeFood,
  }) : super(key: key);

  @override
  ConsumerState<MealTimeFoodCard> createState() => _MealTimeFoodCard();
}

class _MealTimeFoodCard extends ConsumerState<MealTimeFoodCard> {
  String getMealTimeFoodName() {
    if (widget.mealTimeFood.mealId != -1) {
      return widget.mealTimeFood.mealName;
    } else {
      return widget.mealTimeFood.ingredientName;
    }
  }

  Future<void> _deleteItem() async {
    widget.mealTimeFood.isDeleted = true;
    ref.watch(mealtimeFoodProvider.notifier).deleteFoodItem(widget.mealTimeFood);
    ref.watch(mealtimeFoodProvider.notifier).fetchAndSetMealTimeFoods();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        //On double tap should automaically delete it
        _deleteItem();
      },
      onTap: () {
        //on a single tap should open up a Modal - making it more clear on how to delete it
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(getMealTimeFoodName()),
        ),
      ),
    );
  }
}
