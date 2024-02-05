import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ingredient_model.dart';

class IngredientLabelCard extends ConsumerWidget {
  final Ingredient ingredient;

  const IngredientLabelCard({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          ingredient.ingredientName,
        ),
      ),
    );
  }
}
