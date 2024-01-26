import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dayCardProvider = Provider<DayCard>((ref) => DayCard());

class DayCard extends ConsumerWidget {
  @override
    Widget build(BuildContext context, WidgetRef ref) {
      return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowItem("The <>day"),
              RowItem("Row 2 Content"),
              RowItem("Row 3 Content"),
              RowItem("Row 4 Content"),
            ],
          ),
        ),
      );
    }
}


class RowItem extends StatelessWidget {
  final String content;

  RowItem(this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.star),
          SizedBox(width: 8),
          Text(content),
        ],
      ),
    );
  }
}