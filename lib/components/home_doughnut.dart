import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../config/theme/custom_color.g.dart';

class DoughnutChart extends StatefulWidget {
  const DoughnutChart({super.key});

  @override
  State<DoughnutChart> createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData("Debt", 40,
          Theme.of(context).extension<CustomColors>()!.sourceGreenbar!),
      ChartData("Empty", 60, const Color(0xFFE8E8E8))
    ];
    return SfCircularChart(annotations: <CircularChartAnnotation>[
      CircularChartAnnotation(
          widget: Container(
        child: Text("320 THB",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.bold))
            .animate()
            .fadeIn(),
      )),
    ], series: <CircularSeries>[
      DoughnutSeries<ChartData, String>(
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        pointColorMapper: (ChartData data, _) => data.color,
        innerRadius: "95%",
        radius: '85',
        // startAngle: 0,
        // endAngle: 360,
      )
    ]);
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color = Colors.white]);
  final String x;
  final double y;
  final Color color;
}
