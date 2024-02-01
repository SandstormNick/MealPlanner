import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/meal_provider.dart';

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
                        : ListView.builder(
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return const Text('Hello World');
                            },
                          ),
              ),
      ),
    );
  }
}
