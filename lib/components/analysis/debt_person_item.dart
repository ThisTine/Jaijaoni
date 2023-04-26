import 'package:flutter/material.dart';

class DebtPeopleItem extends StatelessWidget {
  const DebtPeopleItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Sittichok", style: Theme.of(context).textTheme.titleSmall),
              Text(
                "809 THB",
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ]),
          ],
        ),
        Text("1 st")
      ],
    );
  }
}
