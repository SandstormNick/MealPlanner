import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddFoodToMealTimeForm extends ConsumerStatefulWidget {
  const AddFoodToMealTimeForm({Key? key}) : super(key: key);

  @override
  ConsumerState<AddFoodToMealTimeForm> createState() =>
      _AddFoodToMealTimeFormState();
}

class _AddFoodToMealTimeFormState extends ConsumerState<AddFoodToMealTimeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: const Scaffold(
        body: Text('This is the Add Form'),
      ),
    );
  }
}
