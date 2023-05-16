import 'package:flutter/material.dart';
import 'package:jaijaoni/config/theme/custom_color.g.dart';

class AnalysisBar extends StatelessWidget {
  final bool isBorrow;
  final double barPercentage;
  final double amountLabel;
  final bool isSelected;

  const AnalysisBar(
      {super.key,
      this.isBorrow = false,
      required this.barPercentage,
      required this.amountLabel,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          amountLabel.toStringAsFixed(2),
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: isBorrow
                  ? (isSelected
                      ? Theme.of(context)
                          .extension<CustomColors>()!
                          .sourceRedbar
                      : Theme.of(context).colorScheme.onSurfaceVariant)
                  : (isSelected
                      ? Theme.of(context)
                          .extension<CustomColors>()!
                          .sourceGreenbar
                      : Theme.of(context).colorScheme.onSurfaceVariant)),
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: 40,
            height: (barPercentage / 100) * 260,
            color: isBorrow
                ? (isSelected
                    ? Theme.of(context).extension<CustomColors>()!.sourceRedbar
                    : Theme.of(context)
                        .extension<CustomColors>()!
                        .sourceRedbar!
                        .withOpacity(0.5))
                : (isSelected
                    ? Theme.of(context)
                        .extension<CustomColors>()!
                        .sourceGreenbar
                    : Theme.of(context)
                        .extension<CustomColors>()!
                        .sourceGreenbar!
                        .withOpacity(0.5)),
          ),
        )
      ],
    );
  }
}
