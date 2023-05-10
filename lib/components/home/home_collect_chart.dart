import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import '../config/theme/custom_color.g.dart';

class CollectChart extends StatefulWidget {
  final double total;
  final double paid;
  const CollectChart({required this.paid, required this.total, super.key});

  @override
  State<CollectChart> createState() => _CollectChartState();
}

class _CollectChartState extends State<CollectChart> {
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [];
    if (widget.paid != 0 && widget.total != 0) {
      chartData = [
        ChartData("Paid", widget.paid / widget.total,
            Theme.of(context).colorScheme.primary),
        ChartData(
            "Unpaid", 1 - (widget.paid / widget.total), const Color(0xFFE8E8E8))
      ];
    } else {
      chartData = [
        ChartData("Paid", 0, Theme.of(context).colorScheme.primary),
        ChartData("Unpaid", 1, const Color(0xFFE8E8E8))
      ];
    }
    return SfCircularChart(annotations: <CircularChartAnnotation>[
      CircularChartAnnotation(
          widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${widget.paid}",
                  style: TextStyle(
                      color: const Color(0xFF5DB075),
                      fontSize:
                          Theme.of(context).textTheme.titleMedium?.fontSize,
                      fontWeight: FontWeight.bold))
              .animate()
              .fadeIn(),
          Text("of ${widget.total} THB",
              style: const TextStyle(
                  color: Color.fromARGB(255, 138, 138, 138), fontSize: 10)),
          const Text("collected",
              style: TextStyle(
                  color: Color.fromARGB(255, 138, 138, 138), fontSize: 10)),
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
