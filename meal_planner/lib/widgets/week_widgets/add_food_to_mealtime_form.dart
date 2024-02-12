import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/day_mealtime_model.dart';

import 'package:meal_planner/providers/day_mealtime_provider.dart';

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
            //_selectedCategory == 'meals' ? DropdownButton(items: items, onChanged: onChanged)
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
