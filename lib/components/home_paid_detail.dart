import 'package:flutter/material.dart';

import '../screens/analysis.dart';

class PaidDetail extends StatelessWidget {
  const PaidDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("6",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                    fontWeight: FontWeight.bold,
                    height: 0.8)),
            Text(" friends",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                    height: 0.8)),
          ],
        ),
        Text("you're in debt with.",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize)),
        const SizedBox(
          height: 12,
        ),
        FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              fixedSize: const Size(100, 35)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DebtAnalysisScreen()));
          },
          child: const Text(
            "more details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
