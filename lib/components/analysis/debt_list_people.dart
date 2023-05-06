import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/analysis/get_borrowers_by_month_label.dart';

import 'debt_list_mock.dart';
import 'debt_person_item.dart';

class DebtListPeople extends StatefulWidget {
  final String monthLabel;
  const DebtListPeople({
    super.key,
    required this.monthLabel,
  });

  @override
  State<DebtListPeople> createState() => _DebtListPeopleState();
}

class _DebtListPeopleState extends State<DebtListPeople> {
  Set<bool> _isLent = {false};
  List<DebtPeopleItemObject> debtpeople = [];

  void getData() {
    getBorrowersbymonthLabel(widget.monthLabel).then((value) {
      setState(() {
        debtpeople = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    mockDataDebtList.sort(
      (a, b) => a['price'] > b['price'] ? 0 : 1,
    );

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
        ...debtpeople
            .where((element) =>
                // element['montLabel'] == widget.monthLabel &&
                element.isLent == _isLent.first)
            .toList()
            .asMap()
            .entries
            .map((e) => DebtPeopleItem(
                id: e.key.toString(),
                name: e.value.name,
                price: e.value.total,
                profileImage: "https://i.pravatar.cc/150?img=${e.value.id}",
                position: e.key + 1))
      ],
    );
  }
}
