import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import '../config/theme/custom_color.g.dart';

class PaidChart extends StatefulWidget {
  const PaidChart({super.key});

  @override
  State<PaidChart> createState() => _PaidChartState();
}

class _PaidChartState extends State<PaidChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData("Paid", 70, Theme.of(context).colorScheme.primary),
      ChartData("Unpaid", 30, const Color(0xFFE8E8E8))
    ];
    return SfCircularChart(annotations: <CircularChartAnnotation>[
      CircularChartAnnotation(
          widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("1960 THB",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium?.fontSize,
                      fontWeight: FontWeight.bold))
              .animate()
              .fadeIn(),
          const Text("of 3200 THB",
              style: TextStyle(color: Color(0xFFE8E8E8), fontSize: 10)),
          const Text("paid",
              style: TextStyle(color: Color(0xFFE8E8E8), fontSize: 10)),
        ],
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
