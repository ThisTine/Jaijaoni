import 'package:flutter/material.dart';

import 'debt_person_item.dart';

class DebtListPeople extends StatelessWidget {
  const DebtListPeople({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedButton(
          segments: const [
            ButtonSegment(
                value: 1, icon: Icon(Icons.abc), label: Text("Borrow")),
            ButtonSegment(value: 2, icon: Icon(Icons.abc), label: Text("lent"))
          ],
          selected: {1},
          multiSelectionEnabled: false,
        ),
        for (int i = 0; i < 10; i++) DebtPeopleItem()
      ],
    );
  }
}
