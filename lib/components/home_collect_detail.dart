import 'package:flutter/material.dart';

class CollectDetail extends StatelessWidget {
  const CollectDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("8",
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
              fixedSize: const Size(125, 40)),
          onPressed: () {},
          child: const Text(
            "more details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
