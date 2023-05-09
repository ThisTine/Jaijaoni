import 'package:flutter/material.dart';
import 'package:jaijaoni/screens/analysis.dart';

class CollectDetail extends StatelessWidget {
  final int debtor;
  const CollectDetail({super.key, required this.debtor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(debtor.toString(),
                style: TextStyle(
                    color: const Color(0xFF5DB075),
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
        Text("in debt to you.",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize)),
        const SizedBox(
          height: 12,
        ),
        FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF5DB075),
              fixedSize: const Size(130, 40)),
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
                fontSize: 16,
                overflow: TextOverflow.visible),
          ),
        )
      ],
    );
  }
}
