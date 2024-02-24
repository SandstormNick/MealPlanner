import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAlertDialog extends ConsumerWidget {
  final String alertType;
  final String alertHeading;

  const CustomAlertDialog({
    super.key,
    required this.alertType,
    required this.alertHeading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text('$alertHeading Already Exists'),
      content:
          Text('This $alertType already exists.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog and pass true
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
