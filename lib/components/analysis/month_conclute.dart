import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jaijaoni/components/analysis/analysis_bar.dart';

class BarValue {
  final double amountLabel;
  final double barPercentage;
  BarValue({required this.amountLabel, required this.barPercentage});
}

class MonthConclute extends StatelessWidget {
  final BarValue rentBar;
  final BarValue borrowBar;
  final String text;
  final bool isSelected;
  const MonthConclute(
      {super.key,
      required this.rentBar,
      required this.borrowBar,
      required this.text,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnalysisBar(
              isBorrow: true,
              amountLabel: borrowBar.amountLabel,
              barPercentage: borrowBar.barPercentage,
              isSelected: isSelected,
            ),
            const SizedBox(
              width: 5,
            ),
            AnalysisBar(
              amountLabel: rentBar.amountLabel,
              barPercentage: rentBar.barPercentage,
              isSelected: isSelected,
            ),
          ],
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }
}
