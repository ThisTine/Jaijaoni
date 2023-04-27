import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/analysis/analysis_bar.dart';

import '../../providers/analysis/analysis_provider.dart';

class BarValue {
  final double amountLabel;
  final double barPercentage;
  BarValue({required this.amountLabel, required this.barPercentage});
}

class MonthConclute extends ConsumerWidget {
  final BarValue lentBar;
  final BarValue borrowBar;
  final String text;
  final bool isSelected;
  const MonthConclute(
      {super.key,
      required this.lentBar,
      required this.borrowBar,
      required this.text,
      this.isSelected = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            print(text);
            ref.read(analysisProivder.notifier).state.selectedBar = text;
          },
          child: Column(
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
                    amountLabel: lentBar.amountLabel,
                    barPercentage: lentBar.barPercentage,
                    isSelected: isSelected,
                  ),
                ],
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        ),
      ],
    );
  }
}
