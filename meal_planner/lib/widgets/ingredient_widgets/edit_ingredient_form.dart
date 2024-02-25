import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditIngredientForm extends ConsumerStatefulWidget {
  const EditIngredientForm({super.key});

  @override
  ConsumerState<EditIngredientForm> createState() => _EditIngredientFormState();
}

class _EditIngredientFormState extends ConsumerState<EditIngredientForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Text('The new Form'),
    );
  }
}
