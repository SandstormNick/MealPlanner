import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal_model.dart';

import './meal_widgets/edit_meal_form.dart';

class MealLabelCard extends ConsumerWidget {
  final Meal meal;

  const MealLabelCard({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return EditMealForm(
              isAdding: false,
              meal: meal,
            );
          },
        );
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            meal.mealName,
          ),
        ),
      ),
    );
  }
}
