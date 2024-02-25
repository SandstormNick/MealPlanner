import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/meal_model.dart';

import '../../providers/meal_provider.dart';

import '../alert_dialog.dart';

class EditMealForm extends ConsumerStatefulWidget {
  final bool isAdding;
  final Meal? meal;

  const EditMealForm({
    Key? key,
    required this.isAdding,
    this.meal,
  }) : super(key: key);

  @override
  ConsumerState<EditMealForm> createState() => _EditMealFormState();
}

class _EditMealFormState extends ConsumerState<EditMealForm> {
  final _formKey = GlobalKey<FormState>();
  final _mealNameController = TextEditingController();

  String? _validateMealName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a meal name.';
    }
    return null;
  }

  Future<void> _showAlertDialog(String mealName) async {
    await showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        alertType: 'Meal',
        alertHeading: mealName,
      ),
    );
  }

  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate()) {
      var newMealName = _mealNameController.text;

      if (widget.meal!.mealName.toLowerCase() != newMealName.toLowerCase()) {
        if (ref.watch(mealProvider.notifier).checkIfMealExists(newMealName)) {
          await _showAlertDialog(newMealName);
        } else {
          if (widget.isAdding) {
            ref.watch(mealProvider.notifier).addMeal(_mealNameController.text);
          } else {
            widget.meal!.mealName = newMealName;
            ref.watch(mealProvider.notifier).updateMeal(widget.meal!);
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isAdding) {
      _mealNameController.text = widget.meal!.mealName;
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
                ? const Text('Add Meal')
                : Text('Edit ${widget.meal!.mealName}'),
            TextFormField(
              controller: _mealNameController,
              decoration: const InputDecoration(labelText: 'Meal Name'),
              validator: _validateMealName,
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
