import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/models/ingredient_model.dart';

import '../../models/day_mealtime_model.dart';
import '../../models/meal_model.dart';

import 'package:meal_planner/providers/day_mealtime_provider.dart';
import '../../providers/meal_provider.dart';
import '../../providers/ingredient_provider.dart';

class AddFoodToMealTimeForm extends ConsumerStatefulWidget {
  final int dayMealTimeId;

  //Use this to run a custom query to get the Day and Mealtime Names

  const AddFoodToMealTimeForm({
    Key? key,
    required this.dayMealTimeId,
  }) : super(key: key);

  @override
  ConsumerState<AddFoodToMealTimeForm> createState() =>
      _AddFoodToMealTimeFormState();
}

class _AddFoodToMealTimeFormState extends ConsumerState<AddFoodToMealTimeForm> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = 'meals'; // Default selection

  @override
  Widget build(BuildContext context) {
    DayMealTime dayMealTime = ref
        .watch(dayMealTimeProvider.notifier)
        .getDayMealTimeById(widget.dayMealTimeId);

    List<Meal> meals = ref.watch(mealProvider.notifier).getAllMeals();
    List<Ingredient> ingredients = ref.watch(ingredientProvider.notifier).getAllIngredients();

    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${dayMealTime.dayName} - ${dayMealTime.mealTimeName}'),
            Row(
              children: [
                Radio(
                  value: 'meals',
                  groupValue: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value.toString();
                    });
                  },
                ),
                Text('Meals'),
                Radio(
                  value: 'ingredients',
                  groupValue: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value.toString();
                    });
                  },
                ),
                Text('Ingredients'),
              ],
            ),
            _selectedCategory == 'meals'
                ? DropdownButton<Meal>(
                    items: meals.map((meal) {
                      return DropdownMenuItem<Meal>(
                        value: meal,
                        child: Text(meal.mealName),
                      );
                    }).toList(),
                    onChanged: (_) {})
                : DropdownButton<Ingredient>(
                    items: ingredients.map((ingredient) {
                      return DropdownMenuItem<Ingredient>(
                        value: ingredient,
                        child: Text(ingredient.ingredientName),
                      );
                    }).toList(),
                    onChanged: (_) {}),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('ADD'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
