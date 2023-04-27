import 'package:flutter/material.dart';

class DebtPeopleItem extends StatelessWidget {
  final String name;
  final double price;
  final String? profileImage;
  final int position;
  const DebtPeopleItem(
      {super.key,
      required this.name,
      required this.price,
      required this.profileImage,
      required this.position});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(foregroundImage: NetworkImage(profileImage ?? "")),
                const SizedBox(
                  width: 10,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(name, style: Theme.of(context).textTheme.titleSmall),
                  Text(
                    "$price THB",
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ]),
              ],
            ),
            if (position < 4 && position > 0)
              CircleAvatar(
                foregroundImage: AssetImage(
                    "images/analysis/${position == 1 ? "1st" : position == 2 ? "2nd" : "3rd"}.png"),
              )
          ],
        ),
        SizedBox(
          height: 1,
          child: Container(color: Theme.of(context).colorScheme.outline),
        )
      ],
    );
  }
}
