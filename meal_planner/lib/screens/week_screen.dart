import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/day_mealtime_provider.dart';
import '../providers/meal_provider.dart';
import '../providers/ingredient_provider.dart';
import '../providers/mealtime_food_provider.dart';

import '../widgets/day_card.dart';

import '../models/day_mealtime_model.dart';

class WeekScreen extends ConsumerWidget {
  const WeekScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mealProvider.notifier).fetchAndSetMeals();
    ref.watch(ingredientProvider.notifier).fetchAndSetIngredients();
    ref.watch(mealtimeFoodProvider.notifier).fetchAndSetMealTimeFoods();

    return Scaffold(
      body: FutureBuilder(
        future:
            ref.read(dayMealTimeProvider.notifier).fetchAndSetDayMealTimes(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer(
                builder: (context, ref, child) {
                  ref.watch(mealtimeFoodProvider);

                  return ListView.builder(
                    itemCount:
                        (ref.watch(dayMealTimeProvider).length / 3).ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      int start = index * 3;
                      int end =
                          (start + 3) > ref.watch(dayMealTimeProvider).length
                              ? ref.watch(dayMealTimeProvider).length
                              : (start + 3);

                      List<DayMealTime> sublist =
                          ref.watch(dayMealTimeProvider).sublist(start, end);

                      return DayCard(dayMealTimeList: sublist);
                    },
                  );
                }),
      ),
    );
  }
}
