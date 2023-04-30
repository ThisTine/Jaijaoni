import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../config/theme/custom_color.g.dart';

class CollectChart extends StatefulWidget {
  const CollectChart({super.key});

  @override
  State<CollectChart> createState() => _CollectChartState();
}

class _CollectChartState extends State<CollectChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData("Collected", 40, const Color(0xFF5DB075)),
      // Theme.of(context).extension<CustomColors>()!.sourceGreenbar!
      ChartData("Uncollected", 60, const Color(0xFFE8E8E8))
    ];
    return SfCircularChart(annotations: <CircularChartAnnotation>[
      CircularChartAnnotation(
          widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("324 THB",
                  style: TextStyle(
                      color: const Color(0xFF5DB075),
                      fontSize:
                          Theme.of(context).textTheme.titleMedium?.fontSize,
                      fontWeight: FontWeight.bold))
              .animate()
              .fadeIn(),
          const Text("of 1056.78 THB",
              style: TextStyle(color: Color(0xFFE8E8E8), fontSize: 10)),
          const Text("collected",
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
