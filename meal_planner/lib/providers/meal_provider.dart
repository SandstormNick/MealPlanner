import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal_model.dart';  //should be able to remove

class MealNotifier extends StateNotifier<List<Meal>> {
  MealNotifier() : super([]);
}

final mealProvider = StateNotifierProvider<MealNotifier, List<Meal>>((ref) {
  return MealNotifier();
});