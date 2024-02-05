import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ingredient_provider.dart';

import '../widgets/ingredient_label_card.dart';

class IngredientsScreen extends ConsumerWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        future: ref.read(ingredientProvider.notifier).fetchAndSetIngredients(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer(
                child: const Center(
                  child: Text('Add Ingredients'),
                ),
                builder: (context, ref, child) => ref
                        .watch(ingredientProvider)
                        .isEmpty
                    ? child!
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: ref.watch(ingredientProvider).length,
                              itemBuilder: (BuildContext context, int index) {
                                final ingredient = ref
                                    .watch(ingredientProvider)
                                    .elementAt(index);
                                return IngredientLabelCard(ingredient: ingredient);
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Add Ingredient'),
                            ),
                          )
                        ],
                      ),
              ),
      ),
    );
  }
}
