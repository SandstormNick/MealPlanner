import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/db_helper.dart';

import '../models/mealtime_food_model.dart';

class MealTimeFoodNotifier extends StateNotifier<List<MealTimeFood>> {
  MealTimeFoodNotifier(): super([]);
}

final mealtimeFoodProvider = StateNotifierProvider<MealTimeFoodNotifier, List<MealTimeFood>>((ref) {
  return MealTimeFoodNotifier();
});