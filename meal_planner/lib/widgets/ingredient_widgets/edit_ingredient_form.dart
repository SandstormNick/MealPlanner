import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/ingredient_model.dart';

import '../../providers/ingredient_provider.dart';

import '../alert_dialog.dart';

class EditIngredientForm extends ConsumerStatefulWidget {
  final bool isAdding;
  final Ingredient? ingredient;

  const EditIngredientForm({
    Key? key,
    required this.isAdding,
    this.ingredient,
  }) : super(key: key);

  @override
  ConsumerState<EditIngredientForm> createState() => _EditIngredientFormState();
}

class _EditIngredientFormState extends ConsumerState<EditIngredientForm> {
  final _formKey = GlobalKey<FormState>();
  final _ingredientNameController = TextEditingController();

  String? _validateIngredientName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an ingredient name.';
    }
    return null;
  }

  Future<void> _showAlertDialog(String ingredientName) async {
    await showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        alertType: 'Ingredient',
        alertHeading: ingredientName,
      ),
    );
  }

  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate()) {
      var newIngredientName = _ingredientNameController.text;
      bool skipSave = false;
      bool nameAlreadyExists = false;

      if (!widget.isAdding &&
          widget.ingredient!.ingredientName.toLowerCase() ==
              newIngredientName.toLowerCase()) {
        skipSave = true;
      }

      if (!skipSave) {
        if (ref
            .watch(ingredientProvider.notifier)
            .checkIfIngredientExists(newIngredientName)) {
          nameAlreadyExists = true;
          await _showAlertDialog(newIngredientName);
        } else {
          if (widget.isAdding) {
            ref
                .watch(ingredientProvider.notifier)
                .addIngredient(newIngredientName);
          } else {
            widget.ingredient!.ingredientName = newIngredientName;
            ref
                .watch(ingredientProvider.notifier)
                .updateIngredient(widget.ingredient!);
          }
        }
      }

      if (mounted && !nameAlreadyExists) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isAdding) {
      _ingredientNameController.text = widget.ingredient!.ingredientName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            widget.isAdding
                ? const Text('Add Ingredient')
                : Text('Edit ${widget.ingredient!.ingredientName}'),
            TextFormField(
              controller: _ingredientNameController,
              decoration: const InputDecoration(labelText: 'Ingredient Name'),
              validator: _validateIngredientName,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _saveItem(),
                child: const Text('SAVE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
