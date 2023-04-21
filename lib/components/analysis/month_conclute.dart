import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MonthConclute extends StatelessWidget {
  const MonthConclute({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                const Text("200"),
                Container(
                  width: 20,
                  height: 100,
                  color: Colors.red,
                )
              ],
            ),
            Column(
              children: [
                const Text("200"),
                Container(
                  width: 20,
                  height: 50,
                  color: Colors.green,
                )
              ],
            )
          ],
        ),
        Text("Jan")
      ],
    );
  }
}
