import 'package:flutter/material.dart';
import 'package:jaijaoni/components/home/home_collect_chart.dart';
import 'package:jaijaoni/components/home/home_collect_detail.dart';
import 'package:jaijaoni/components/home/home_paid_chart.dart';
import 'package:jaijaoni/components/home/home_paid_detail.dart';
import 'package:jaijaoni/functions/home/get_chart.dart';

class TwoChartInHome extends StatelessWidget {
  const TwoChartInHome({
    super.key,
    required this.isVisible,
  });

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getChart(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          CircularChart chartData = snapshot.data!;

          return Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 10,
                      child: Visibility(
                        visible: isVisible,
                        child: CollectChart(
                            paid: chartData.lenderPaidDebt,
                            total: chartData.lenderTotalDebt),
                      ),
                    ),
                    Flexible(
                        flex: 8,
                        child: Visibility(
                            visible: isVisible,
                            child: CollectDetail(
                              debtor: chartData.lenderAmount,
                            ))),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 10,
                      child: Visibility(
                        visible: isVisible,
                        child: PaidChart(
                            paid: chartData.borrowerPaidDebt,
                            total: chartData.borrowerTotalDebt),
                      ),
                    ),
                    Flexible(
                        flex: 8,
                        child: Visibility(
                            visible: isVisible,
                            child: PaidDetail(
                              debtor: chartData.borrowerAmount,
                            ))),
                  ]),
            ],
          );
        });
  }
}
