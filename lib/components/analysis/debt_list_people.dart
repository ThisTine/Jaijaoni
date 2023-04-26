import 'package:flutter/material.dart';

class DebtListPeople extends StatelessWidget {
  const DebtListPeople({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: const [
        ButtonSegment(value: 1, icon: Icon(Icons.abc)),
        ButtonSegment(value: 2, icon: Icon(Icons.abc))
      ],
      selected: {1},
      multiSelectionEnabled: false,
    );
  }
}
