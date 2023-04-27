import 'package:flutter/material.dart';

import 'debt_person_item.dart';

class DebtListPeople extends StatefulWidget {
  const DebtListPeople({
    super.key,
  });

  @override
  State<DebtListPeople> createState() => _DebtListPeopleState();
}

class _DebtListPeopleState extends State<DebtListPeople> {
  Set<bool> _isLent = {false};
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedButton(
          segments: const [
            ButtonSegment(value: true, label: Text("Lent")),
            ButtonSegment(value: false, label: Text("Borrow"))
          ],
          selected: _isLent,
          onSelectionChanged: (p0) {
            setState(() {
              _isLent = p0;
            });
          },
          multiSelectionEnabled: false,
        ),
        for (int i = 0; i < 10; i++)
          DebtPeopleItem(
            name: "Tine",
            position: i + 1,
            price: 200,
            profileImage: "https://www.thistine.com/img/me.webp",
          )
      ],
    );
  }
}
