import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteFoodItemForm extends ConsumerStatefulWidget {
  const DeleteFoodItemForm({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<DeleteFoodItemForm> createState() => _DeleteFoodItemFormState();
}

class _DeleteFoodItemFormState extends ConsumerState<DeleteFoodItemForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Hello'),
          ],
        ),
      ));
  }
}
