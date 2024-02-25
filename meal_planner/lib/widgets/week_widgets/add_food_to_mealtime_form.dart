import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/models/ingredient_model.dart';

import '../../models/day_mealtime_model.dart';
import '../../models/meal_model.dart';

import '../../providers/day_mealtime_provider.dart';
import '../../providers/meal_provider.dart';
import '../../providers/ingredient_provider.dart';
import '../../providers/mealtime_food_provider.dart';

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
  bool _isMeal = true; // Default selection
  int _foodItemId = 0;
  String _foodItemName = "";

  @override
  Widget build(BuildContext context) {
    DayMealTime dayMealTime = ref
        .watch(dayMealTimeProvider.notifier)
        .getDayMealTimeById(widget.dayMealTimeId);

    List<Meal> meals = ref.watch(mealProvider.notifier).getAllMeals();
    List<Ingredient> ingredients =
        ref.watch(ingredientProvider.notifier).getAllIngredients();

    void setFoodItemId(int itemId) {
      _foodItemId = itemId;
    }

    void setFoodItemName(String itemName) {
      _foodItemName = itemName;
    }

    Future<void> save() async {
      if (_foodItemId != 0) {
        ref
            .watch(mealtimeFoodProvider.notifier)
            .addFoodItem(dayMealTime.dayMealTimeId, _foodItemId, _foodItemName, _isMeal);
      }
    }

    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('${dayMealTime.dayName} - ${dayMealTime.mealTimeName}'),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isMeal,
                  onChanged: (value) {
                    setState(() {
                      _isMeal = value!;
                    });
                  },
                ),
                const Text('Meals'),
                Radio(
                  value: false,
                  groupValue: _isMeal,
                  onChanged: (value) {
                    setState(() {
                      _isMeal = value!;
                    });
                  },
                ),
                const Text('Ingredients'),
              ],
            ),
            _isMeal == true
                ? DropdownButton<Meal>(
                    items: meals.map((meal) {
                      return DropdownMenuItem<Meal>(
                        value: meal,
                        child: Text(meal.mealName),
                      );
                    }).toList(),
                    onChanged: (selectedMeal) {
                      if (selectedMeal != null) {
                        setFoodItemId(selectedMeal.mealId!);
                        setFoodItemName(selectedMeal.mealName);
                      }
                    },
                  )
                : DropdownButton<Ingredient>(
                    items: ingredients.map((ingredient) {
                      return DropdownMenuItem<Ingredient>(
                        value: ingredient,
                        child: Text(ingredient.ingredientName),
                      );
                    }).toList(),
                    onChanged: (selectedIngredient) {
                      if (selectedIngredient != null) {
                        setFoodItemId(selectedIngredient.ingredientId!);
                        setFoodItemName(selectedIngredient.ingredientName);
                      }
                    },
                  ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  save();
                },
                child: const Text('ADD'),
              ),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       ref.watch(mealtimeFoodProvider.notifier).printItemsDebugMethod();
            //     },
            //     child: const Text('PRINT'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
