//Phon
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/home_card.dart';
import 'package:jaijaoni/config/theme/custom_color.g.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData("Debt", 40,
          Theme.of(context).extension<CustomColors>()!.sourceGreenbar!),
      ChartData("Empty", 60, Theme.of(context).colorScheme.outline!)
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SfCircularChart(annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                          widget: Container(
                        child: Text("320 THB",
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.fontSize))
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
                    ]),
                    // const SizedBox(
                    //   width: 13,
                    // ),
                    Column(
                      children: const [
                        Text("Test 2", style: TextStyle(fontSize: 30)),
                      ],
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Test 3", style: TextStyle(fontSize: 30)),
                    Column(
                      children: const [
                        Text("Test 4", style: TextStyle(fontSize: 30)),
                      ],
                    )
                  ]),
              // const Text("Test Text", style: TextStyle(fontSize: 30)),
              PayerCard(
                name: "Muaymiiiiiiii",
                image: "images/profile/dazai.jpg",
                circleColor: Theme.of(context).colorScheme.primary,
                amount: "2000",
                days: "3",
              ),
              HomeCard(),
              HomeCard(),
              HomeCard(),
              HomeCard(),
              HomeCard(),
              HomeCard(),
              // Container(
              //   child: Container(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              //     height: MediaQuery.of(context).size.height,
              //     // MediaQuery retrieve the device screen height size
              //     child: ListView.builder(
              //       itemCount: 10,
              //       itemBuilder: (context, index) {
              //         return const MyCard();
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color = Colors.white]);
  final String x;
  final double y;
  final Color color;
}
