import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/analysis/get_borrowers_by_month_label.dart';

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
  // bool isLoading = true;
  // // List<DebtPeopleItemObject> debtpeople = [];

  // void getData() {
  //   getBorrowersbymonthLabel(widget.monthLabel).then((value) {
  //     setState(() {
  //       debtpeople = value;
  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    // print("setting state");
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
              // isLoading = true;
            });
          },
          multiSelectionEnabled: false,
        ),
        FutureBuilder(
          future: getBorrowersbymonthLabel(widget.monthLabel),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.hasError) return Text(snapshot.error.toString());
            var debtpeople = [...snapshot.data ?? []].toList();
            if (debtpeople
                .where((element) => element.isLent == _isLent.first)
                .isEmpty) {
              return const Text("There's no one in the list");
            }
            return Column(
              children: [
                ...debtpeople
                    .where((element) => element.isLent == _isLent.first)
                    .toList()
                    .asMap()
                    .entries
                    .map((e) => DebtPeopleItem(
                        id: e.key.toString(),
                        name: e.value.name,
                        price: e.value.total,
                        profileImage:
                            "https://i.pravatar.cc/150?img=${e.value.id}",
                        position: e.key + 1))
              ],
            );
          },
        ),
        // isLoading
        //     ? const CircularProgressIndicator()
        //     : Column(
        //         children: [
        //           ...debtpeople
        //               .where((element) => element.isLent == _isLent.first)
        //               .toList()
        //               .asMap()
        //               .entries
        //               .map((e) => DebtPeopleItem(
        //                   id: e.key.toString(),
        //                   name: e.value.name,
        //                   price: e.value.total,
        //                   profileImage:
        //                       "https://i.pravatar.cc/150?img=${e.value.id}",
        //                   position: e.key + 1))
        //         ],
        //       )
      ],
    );
  }
}
