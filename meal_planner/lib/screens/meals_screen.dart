import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/meal_provider.dart';

import '../widgets/label_card.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        future: ref.read(mealProvider.notifier).fetchAndSetMeals(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer(
                child: const Center(
                  child: Text('Add Meals'),
                ),
                builder: (context, ref, child) =>
                    ref.watch(mealProvider).isEmpty
                        ? child!
                        : Column(children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: ref.watch(mealProvider).length,
                                itemBuilder: (BuildContext context, int index) {
                                  final meal =
                                      ref.watch(mealProvider).elementAt(index);

                                  return LabelCard(
                                    meal: meal,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Add Meal'),
                              ),
                            ),
                          ]),
              ),
      ),
    );
  }
}

//You could maybe add a property onto the Meal class that sets the first meal in a particular letter to a true boolean
//if (meal.isFirst) {return const Text('A');}
//But then return the letter divider card plus the labelCard...
